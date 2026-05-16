+++
date = "2026-05-16T14:00:00+07:00"
description = ""
draft = false
tags = ["lubuntu", "ubuntu", "luks", "grub", "encryption", "dracut"]
title = "Lubuntu 26.04 Encrypted Disk: Gotchas and Fixes"
+++

## TL;DR

A fresh Lubuntu 26.04 install with "Erase disk and install with encryption" boots straight to a `grub>` rescue prompt. Calamares creates a LUKS2 volume with `argon2id` KDF; Canonical's signed `grubx64.efi` cannot read it.

**To boot at all:** rebuild `grubx64.efi` with `luks2` + `argon2` + `gcry_kdf` + `gcry_sha256` modules, embed a `cryptomount` preamble in the init config.

**If GRUB still can't unlock** (argon2id memory cost too high for older firmware): convert the keyslot to `pbkdf2`.

**For single-prompt boot** (avoid typing the passphrase twice): add a keyfile and dracut hook.

Escape hatch: reinstall with a small unencrypted `/boot` partition that GRUB never has to decrypt. See bottom for details.

This post documents every dead end I hit fixing it on an Acer Aspire V5-573G — a reference for future me and for anyone else who lands at `grub>` after a clean install.

In hindsight I should have picked manual partitioning and a small unencrypted `/boot`. The one-click "erase disk and encrypt" path skips that choice and lands you here.

> Examples below use `/dev/sda2` for the LUKS partition and `/dev/sda1` for the ESP. Substitute your own — `lsblk -f` shows partition types, and `crypto_LUKS` marks the encrypted one. On NVMe systems it will be `nvme0n1p2` or similar.

## The symptom chain

After the installer finishes, the machine reboots and presents `grub>`. Typing `ls (hd0,gpt2)` returns:

```
Partition hd0,gpt2: No known filesystem detected
```

`insmod luks2` fails with `file not found`. `cryptomount` fails with `no such cryptodisk found, perhaps a needed disk or cryptodisk module is not loaded`.

Booting a Lubuntu live USB and running `lsblk -f` shows `crypto_LUKS 2` on `/dev/sda2`. The partition is encrypted — GRUB can't see in.

## Root causes (in chain order)

There isn't one bug. There's a chain.

### 1. Canonical's signed `grubx64.efi` lacks `luks2`

Pulling the embedded module list out of `/usr/lib/grub/x86_64-efi-signed/grubx64.efi.signed` shows 122 modules. `luks` (LUKS1) is there. `luks2` is not. Neither is `argon2` or `gcry_kdf`.

cryptsetup has defaulted to LUKS2 since version 2.1 (2018). The Lubuntu Calamares installer creates LUKS2 volumes. The bootloader Canonical ships cannot read them.

This is by design. Launchpad bug [#1999345](https://bugs.launchpad.net/ubuntu/+source/grub2/+bug/1999345) ("please add luks2 module to the signed grub2 images") is marked **Won't Fix**. The stated reasons: `luks2` pulls in a JSON parser, expanding the attack surface of signed boot code; GRUB's LUKS implementation trails kernel and userspace, so compatibility is fragile; and security updates to signed binaries are expensive, so the module set stays minimal. The maintainer position, roughly: pick between Secure Boot and a custom boot path.

### 2. `luks2.mod` has an unresolved dependency on argon2

`nm /usr/lib/grub/x86_64-efi/luks2.mod` shows `U grub_crypto_argon2`. The `luks2` module references the argon2 KDF function symbol whether or not any keyslot uses argon2. Even after eliminating argon2id keyslots, you must embed `argon2.mod` for `luks2.mod` to load.

`argon2.mod` is a 1.4KB wrapper that pulls in `_gcry_kdf_*` from `gcry_kdf.mod`. Both must be present.

### 3. `grub-install --modules=` has no effect when `grub-efi-amd64-signed` is installed

The natural fix is `grub-install --modules="luks2 argon2 gcry_kdf ..."`. It runs without error. The resulting binary contains none of those modules.

Why: when `grub-efi-amd64-signed` is installed, `grub-install` copies the pre-built `grubx64.efi.signed` to the ESP instead of compiling a fresh binary. No `grub-mkimage` runs, so `--modules` has nothing to act on. Verified by extracting the `mods` PE section with `objcopy -O binary --only-section=mods` and walking the embedded ELF objects: same module set as Canonical's stock build, regardless of `--modules=`.

**Use `grub-mkimage` directly.** It honors `--modules`.

### 4. `gcry_sha256` is required even when your KDF hash is sha512

`cryptsetup luksDump /dev/sda2` showed `Hash: sha512` for the PBKDF and the digest. I added `gcry_sha512` and figured that covered it.

It didn't. `mkdir -p /tmp/mnt && grub-mount -C /dev/sda2 /tmp/mnt` failed with:

```
grub-mount: error: Couldn't load sha256.
```

LUKS2 header parsing uses sha256 internally regardless of which hash the keyslot KDF declares. Add `gcry_sha256.mod`.

### 5. argon2id keyslot may block GRUB unlock (hardware-dependent)

GRUB's argon2 implementation handles header parsing, but unlocking an argon2id-protected keyslot is a separate concern. Memory cost defaults run 700+ MB; on older firmware this can fail or time out.

After reading that GRUB's argon2 support is limited, I converted my passphrase slot to `pbkdf2` upfront. It worked. I never tested whether argon2id alone would have unlocked on this hardware — if you try it without the conversion and it works, I'm curious to hear.

Convert the slot:

```bash
sudo cryptsetup luksConvertKey --pbkdf pbkdf2 /dev/sda2
```

This re-encodes the keyslot header without re-encrypting any data. Fast, reversible. After it runs, `luksDump` shows the slot as `PBKDF: pbkdf2`.

Calamares creates two keyslots by default. Kill the unused argon2id slot so GRUB doesn't trip over it:

```bash
sudo cryptsetup luksKillSlot /dev/sda2 1
```

(Verify which slot you're killing first via `luksDump`. The slot you authenticated against during `luksConvertKey` is the pbkdf2 one.)

### 6. The embedded grub.cfg needs the cryptomount preamble

`grub-mkimage` builds a binary that, at startup, reads `$prefix/grub.cfg`. The default prefix is `/boot/grub` — inside the encrypted partition. Chicken and egg.

Solution: pass `--config=/path/to/init.cfg` with this content:

```
cryptomount -u <luks-uuid-without-dashes>
search.fs_uuid <root-fs-uuid> root cryptouuid/<luks-uuid-without-dashes>
set prefix=($root)/boot/grub
configfile $prefix/grub.cfg
```

Get the UUIDs from `cryptsetup luksDump /dev/sda2` (LUKS UUID) and `blkid /dev/mapper/sda2_crypt` (filesystem UUID). The `cryptouuid/...` form takes the LUKS UUID with dashes stripped.

### 7. Lubuntu 26.04 uses dracut, not initramfs-tools

Most encrypted-disk tutorials assume `/etc/cryptsetup-initramfs/conf-hook` and `update-initramfs -u`. Neither exists on Lubuntu 26.04 — the installed system uses `dracut`. Equivalent paths:

- `/etc/dracut.conf.d/` — drop-in config dir
- `sudo dracut --force` — rebuild initramfs

### 8. crypttab format uses `keyscript=/bin/cat`

Calamares writes a crypttab line like:

```
luks-<UUID> UUID=<UUID> none luks,keyscript=/bin/cat
```

`/bin/cat` pipes whatever was typed at the dracut password prompt straight to cryptsetup. To auto-unlock initramfs with a keyfile, replace `none luks,keyscript=/bin/cat` with `/path/to/keyfile luks`.

## The working build

With all the above in hand, the recipe collapses to:

1. Boot a Lubuntu live USB.
2. Unlock and chroot:

   ```bash
   sudo cryptsetup open /dev/sda2 sda2_crypt
   sudo mount /dev/mapper/sda2_crypt /mnt
   sudo mount /dev/sda1 /mnt/boot/efi
   for d in dev proc sys run dev/pts; do sudo mount --bind /$d /mnt/$d; done
   sudo chroot /mnt
   ```

3. (Optional — try without first.) If GRUB fails to unlock, convert the keyslot to pbkdf2 and remove the argon2id slot:

   ```bash
   cryptsetup luksConvertKey --pbkdf pbkdf2 /dev/sda2
   cryptsetup luksKillSlot /dev/sda2 1   # if a second argon2id slot exists
   ```

   Skip this on the first attempt — try the argon2id slot as-is. If GRUB unlocks, your hardware doesn't need the conversion.

4. Write the init config:

   ```bash
   cat > /etc/grub-custom-init.cfg <<'EOF'
   cryptomount -u <LUKS-UUID-no-dashes>
   search.fs_uuid <FS-UUID> root cryptouuid/<LUKS-UUID-no-dashes>
   set prefix=($root)/boot/grub
   configfile $prefix/grub.cfg
   EOF
   ```

5. Build `grubx64.efi` directly with `grub-mkimage`:

   ```bash
   MODULES="acpi afsplitter archelp argon2 bitmap bitmap_scale boot btrfs bufio cat chain configfile cpuid crypto cryptodisk datetime disk diskfilter echo efi_gop efifwsetup efinet ext2 extcmd fat font fshelp gcry_arcfour gcry_blowfish gcry_camellia gcry_cast5 gcry_crc gcry_des gcry_dsa gcry_hwfeatures gcry_idea gcry_kdf gcry_keccak gcry_md4 gcry_md5 gcry_rfc2268 gcry_rijndael gcry_rmd160 gcry_rsa gcry_seed gcry_serpent gcry_sha1 gcry_sha256 gcry_sha512 gcry_tiger gcry_twofish gcry_whirlpool gettext gfxmenu gfxterm gfxterm_background gzio halt help hfsplus iso9660 jpeg key_protector keystatus linux loadenv loopback ls lsefi lsefimmap lsefisystab lssal luks luks2 lvm lzopio mdraid09 mdraid1x memdisk minicmd mmap mpi net normal part_apple part_gpt part_msdos password_pbkdf2 pbkdf2 peimage play png priority_queue probe procfs pubkey raid5rec raid6rec reboot regexp relocator search search_fs_file search_fs_uuid search_label serial setjmp sleep smbios squash4 terminal terminfo test tpm trig true video video_colors video_fb xfs xzio zfs zfscrypt zfsinfo zstd"
   grub-mkimage \
     --directory=/usr/lib/grub/x86_64-efi \
     --format=x86_64-efi \
     --output=/boot/efi/EFI/ubuntu/grubx64.efi \
     --prefix=/boot/grub \
     --config=/etc/grub-custom-init.cfg \
     $MODULES
   cp /boot/efi/EFI/ubuntu/grubx64.efi /boot/efi/EFI/BOOT/grubx64.efi
   ```

   This list is Canonical's stock module set (extracted from the signed binary) plus `luks2`, `argon2`, and `gcry_kdf` — the three pieces missing from Canonical's signed GRUB.

6. Exit chroot, unmount, reboot. You should land at a single LUKS passphrase prompt, then the Lubuntu desktop.

## Eliminating the second passphrase prompt

The above gets you booting, but you'll type the passphrase twice — once for GRUB (to read the kernel and initrd), once for initramfs (to mount the root). The standard fix puts a keyfile inside the initramfs, itself protected by the first unlock.

```bash
sudo mkdir -p /etc/cryptsetup-keys.d
sudo dd if=/dev/urandom of=/etc/cryptsetup-keys.d/sda2_crypt.key bs=512 count=8
sudo chmod 600 /etc/cryptsetup-keys.d/sda2_crypt.key

sudo cryptsetup luksAddKey /dev/sda2 /etc/cryptsetup-keys.d/sda2_crypt.key

sudo sed -i 's|none luks,keyscript=/bin/cat|/etc/cryptsetup-keys.d/sda2_crypt.key luks|' /etc/crypttab

echo 'install_items+=" /etc/cryptsetup-keys.d/sda2_crypt.key "' | sudo tee /etc/dracut.conf.d/crypt-key.conf

sudo dracut --force
sudo reboot
```

The keyfile lives in the encrypted partition. GRUB's first unlock decrypts the entire root, including the keyfile and the initramfs that contains it. The initramfs then reads its embedded keyfile and unlocks the same LUKS volume without prompting again.

argon2id is fine for this keyslot — initramfs uses full cryptsetup, which handles argon2id natively. The GRUB-vs-cryptsetup constraint applies only to the pbkdf2 slot used at boot.

## Protecting against package upgrades

The next `apt upgrade` that pulls in `grub-efi-amd64-signed` will overwrite your custom `grubx64.efi` with Canonical's signed (LUKS2-blind) version, breaking boot again. Three options:

- `apt-mark hold grub-efi-amd64-signed grub-common grub-efi-amd64-bin shim-signed` — costs you security updates.
- A DPkg post-invoke hook that re-runs `grub-mkimage` after every apt operation — recommended.
- Ship `systemd-boot` instead of GRUB — bigger change, out of scope here.

The post-invoke hook:

```bash
# /usr/local/sbin/build-custom-grubx64.sh
#!/usr/bin/env bash
set -e
[ -d /boot/efi/EFI/ubuntu ] || exit 0
MODULES="acpi afsplitter archelp argon2 bitmap bitmap_scale boot btrfs bufio cat chain configfile cpuid crypto cryptodisk datetime disk diskfilter echo efi_gop efifwsetup efinet ext2 extcmd fat font fshelp gcry_arcfour gcry_blowfish gcry_camellia gcry_cast5 gcry_crc gcry_des gcry_dsa gcry_hwfeatures gcry_idea gcry_kdf gcry_keccak gcry_md4 gcry_md5 gcry_rfc2268 gcry_rijndael gcry_rmd160 gcry_rsa gcry_seed gcry_serpent gcry_sha1 gcry_sha256 gcry_sha512 gcry_tiger gcry_twofish gcry_whirlpool gettext gfxmenu gfxterm gfxterm_background gzio halt help hfsplus iso9660 jpeg key_protector keystatus linux loadenv loopback ls lsefi lsefimmap lsefisystab lssal luks luks2 lvm lzopio mdraid09 mdraid1x memdisk minicmd mmap mpi net normal part_apple part_gpt part_msdos password_pbkdf2 pbkdf2 peimage play png priority_queue probe procfs pubkey raid5rec raid6rec reboot regexp relocator search search_fs_file search_fs_uuid search_label serial setjmp sleep smbios squash4 terminal terminfo test tpm trig true video video_colors video_fb xfs xzio zfs zfscrypt zfsinfo zstd"
grub-mkimage \
  --directory=/usr/lib/grub/x86_64-efi \
  --format=x86_64-efi \
  --output=/boot/efi/EFI/ubuntu/grubx64.efi \
  --prefix=/boot/grub \
  --config=/etc/grub-custom-init.cfg \
  $MODULES
cp /boot/efi/EFI/ubuntu/grubx64.efi /boot/efi/EFI/BOOT/grubx64.efi
echo "[$(date -Iseconds)] custom grubx64.efi rebuilt" >> /var/log/custom-grubx64.log
```

```bash
# /etc/apt/apt.conf.d/99-custom-grubx64
DPkg::Post-Invoke {"/usr/local/sbin/build-custom-grubx64.sh || true";};
```

The script is idempotent and finishes in well under a second. The cost on every apt invocation is negligible.

## Smaller gotchas worth noting

- **`grub-install` writes the binary but warns "EFI variables cannot be set on this system"** when run from chroot. Harmless — the file on disk is rewritten, and UEFI NVRAM entries from the original install already point at the right path.
- **`SecureBoot validation is disabled in shim`** is what Calamares sets up (effectively `mokutil --disable-validation`). It lets your unsigned custom GRUB chain-load. Flip it back on and your custom binary will be rejected.
- **The "Hash" field in `luksDump` is misleading** — it documents the PBKDF hash, not the only hash the LUKS2 header uses. Always include `gcry_sha256`.
- **`grub-mount -C` is a useful diagnostic** — it uses GRUB's actual LUKS code in userspace. If grub-mount can decrypt, the boot-stage decryption will too.
- **Bootloader binaries should live in both `/EFI/ubuntu/` and `/EFI/BOOT/`** as fallback. Some firmwares boot the latter when NVRAM is reset.
- **`grub.cfg` failures after a successful unlock surface as a black screen** because the generated `/boot/grub/grub.cfg` calls `terminal_output gfxterm` early. If that fails, the menu is invisible but navigable — arrows and Enter still select entries you can't see. Set `GRUB_TERMINAL=console` in `/etc/default/grub` and re-run `update-grub` to get a visible menu.

## Escape hatches: skip the chain entirely

For a frictionless install today, set up a small unencrypted `/boot` partition that GRUB never needs to decrypt. Avoids the entire chain above.

But if you're staring at a `grub>` prompt right now and don't want to reinstall — the recipe above works.

## References

- [Launchpad bug #1999345 — please add luks2 module to the signed grub2 images](https://bugs.launchpad.net/ubuntu/+source/grub2/+bug/1999345) (Won't Fix, with Canonical's rationale)
- [Launchpad bug #1565950 — Grub 2 fails to boot a kernel on a luks encrypted partition](https://bugs.launchpad.net/ubuntu/+source/grub2/+bug/1565950) (signed binary mechanism)
