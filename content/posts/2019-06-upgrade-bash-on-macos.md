+++
date = "2019-06-14T10:23:00+07:00"
description = ""
draft = false
tags = ["macos", "bash", "shell"]
title = "Upgrade bash on macOS"
aliases = ["/post/upgreade-bash-on-macosx/"]
+++

macOS ships an old 3.x bash. Most Linux hosts have bash 4.x or 5.x. That mismatch makes scripts you wrote on Linux misbehave on your Mac (and vice versa) for no good reason.

<!--more-->

> **Note (2026):** macOS Catalina (2019) and later default to **zsh**, not bash. This post still applies if you're explicitly using bash — but most users have moved on. Apple kept bash 3.2 in `/bin/bash` for license reasons (GPLv3 avoidance). Homebrew installs a newer bash to `/opt/homebrew/bin/bash` (Apple Silicon) or `/usr/local/bin/bash` (Intel).

## Install via Homebrew

```bash
brew install bash
```

That installs current bash (5.x as of 2019, 5.2+ in 2026) alongside Apple's `/bin/bash`. To make it your default:

```bash
# Add the new shell to /etc/shells
sudo bash -c "echo $(brew --prefix)/bin/bash >> /etc/shells"

# Change your login shell
chsh -s $(brew --prefix)/bin/bash
```

Verify:

```bash
$ bash --version
GNU bash, version 5.0.2(1)-release (x86_64-apple-darwin18.2.0)
```

Much better.

## References

- [Upgrading Bash on macOS](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba)
