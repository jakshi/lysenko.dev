+++
title = "nuls - A Modern ls with Table Output"
date = "2026-03-02T12:00:00+07:00"
draft = false
tags = ["cli", "tools", "rust"]
description = ""
+++

[nuls](https://github.com/cesarferreira/nuls) is a NuShell-inspired `ls` replacement written in Rust that prints directory listings as a clean, colorful table.

What makes it nice to use:
- Table layout with columns for name, type, size, and modification time
- Directories are listed first, color-coded by file type
- Human-readable file sizes
- Timestamps colored by recency - green for recent, fading to gray for older files
- Git status inline with `-g` flag (shows changed lines per file)

## Install

```bash
brew install nuls
```

## Alias

A good alias to make it your default detailed listing:

```bash
alias lsn="nuls -lag"  # -g shows git status
```

## Screenshot

![nuls screenshot](/img/nuls-screenshot.png)

https://github.com/cesarferreira/nuls
