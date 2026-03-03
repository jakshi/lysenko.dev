+++
title = "Serie - Beautiful Git Commit Graph in Your Terminal"
date = "2026-03-03T10:00:00+07:00"
draft = false
tags = ["git", "cli", "tools"]
description = ""
+++

[Serie](https://github.com/lusingander/serie) renders a rich git commit graph directly in your terminal — like `git log --graph --all`, but actually readable.

It uses terminal image protocols (iTerm2, Kitty) to draw smooth branch lines with colors, and provides a TUI for browsing commits, searching, and viewing diffs.

## Install

```bash
brew install serie
```

## Usage

```bash
cd your-repo
serie
```

A handy git alias to keep it short:

```bash
git config --global alias.lg '!serie'  # or git tree
git lg
```

![serie screenshot](/img/serie-screenshot.png)

**Note:** requires a terminal with image protocol support (iTerm2, Kitty, Ghostty). Does not work inside tmux/screen.

https://github.com/lusingander/serie
