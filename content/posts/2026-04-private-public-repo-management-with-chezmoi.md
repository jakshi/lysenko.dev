+++
date = "2026-04-29T14:00:00+07:00"
description = ""
draft = false
tags = ["chezmoi", "just", "git"]
title = "Tracking private and public parts of the same project with chezmoi"
+++

I keep some files inside my project's working directory that don't belong to the project. Editor config. Claude Code settings under `.claude/`. A `justfile.local` with maintainer-only commands. They're useful only to me, but I want them version-controlled — across machines, with history.

They can't go in the public repo. I needed a way to track them that stays out of the public history, stays out of contributors' way, and stays restorable on a fresh machine.

Here's the shape that works for me.

<!--more-->

## The shape

- the project repo is public-ready
- the chezmoi repo holds dotfiles and project-local private files
- the project's `.gitignore` excludes the private paths
- the public `justfile` optionally imports `justfile.local`
- chezmoi writes the private layer into the project's working tree

On disk, public and private files live side by side. In git history, the project repo sees only the public ones.

## Walk-through

The project on disk:

```text
telegram-rust-cli/
  src/
  README.md
  Cargo.toml
  justfile
  .gitignore
  .claude/          # ignored by project git, tracked by chezmoi
  justfile.local    # ignored by project git, tracked by chezmoi
```

The project `.gitignore`:

```gitignore
.claude/
justfile.local
config.toml
.env
```

The public `justfile`:

```make
set shell := ["bash", "-cu"]

import? 'justfile.local'

default:
    @just --list

fmt:
    cargo fmt --check

test:
    cargo test

clippy:
    cargo clippy --all-targets --all-features -- -D warnings

audit:
    cargo audit

fast-check: fmt clippy

check: fmt test clippy audit
```

The line that makes this work:

```make
import? 'justfile.local'
```

The `?` makes the import optional. Contributors and CI don't need `justfile.local`. If the file is missing, `just` continues normally. On my machine, the file exists and adds private commands.

My `justfile.local`:

```make
chezmoi_source := `chezmoi source-path`
private_claude := justfile_directory() / ".claude"
private_justfile := justfile_directory() / "justfile.local"

private-help:
    @echo "Private project state is managed by chezmoi."

private-status:
    git -C "{{chezmoi_source}}" status -sb

private-diff:
    chezmoi diff "{{private_claude}}"
    chezmoi diff "{{private_justfile}}"

private-save:
    chezmoi re-add "{{private_claude}}"
    chezmoi re-add "{{private_justfile}}"
    git -C "{{chezmoi_source}}" status --short

private-commit message:
    git -C "{{chezmoi_source}}" add .
    git -C "{{chezmoi_source}}" commit -m "{{message}}"

private-push:
    git -C "{{chezmoi_source}}" push
```

In the chezmoi source repo, the same files live under the project's path:

```text
chezmoi-dotfiles/
  git-repos/
    telegram-rust-cli/
      dot_claude/
        settings.json
      justfile.local
```

## Day-to-day

After editing private files I run:

```bash
just private-diff
just private-save
just private-commit "Update private project settings"
just private-push
```

On a new machine or after a fresh clone of the project at the same path:

```bash
chezmoi apply
```

Both `.claude/` and `justfile.local` come back where they belong, and the project's public commands stay unchanged.

## Why chezmoi fits

Chezmoi is usually pitched as a dotfiles manager, but it's more accurate to call it a personal machine-state manager. It can track files at any path on your machine, with any name. Project-local files inside a public project's working tree are fair game.

## The two-repo alternative

Another shape is to keep two repos for the same project — a private development one and a public release one — and snapshot between them. I haven't lived with that workflow so I won't argue against it. It just looked less convenient to me, since every change forces a "which repo?" decision.

## The split that makes it work

The public project should be understandable without my private environment. My private environment should be restorable without polluting the public project.

Optional imports, `.gitignore`, and chezmoi are enough to make that split practical.
