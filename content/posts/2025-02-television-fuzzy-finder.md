+++
title = "Television - Fuzzy Finder for Files, Text, Git Logs and More"
date = "2025-02-16T10:00:00+07:00"
draft = false
tags = ["cli", "rust", "fuzzy-finder", "tools"]
description = ""
+++

Need a fast fuzzy finder that searches more than just files? [Television](https://github.com/alexpasmantier/television) is a terminal-based fuzzy finder written in Rust that can search files, text, git logs, environment variables, docker containers, and whatever else you want.

The key concept is `channels` - customizable search profiles that define what to search and how to display results. You can create your own channels via TOML config files.

## Install and use

```bash
brew install television
tv          # search files
tv text     # search file contents
tv git-log  # search git logs
```

## Zed integration

Television can be used to get a [Telescope-like experience in Zed](https://zed.dev/blog/hidden-gems-part-2#emulate-vims-telescope-via-television) by adding a custom task that runs `zed "$(tv files)"` and binding it to `cmd-p`.

https://github.com/alexpasmantier/television
