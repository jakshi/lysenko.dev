+++
title = "Bash - Restrict Interactive-Only Commands"
date = "2025-10-27T10:00:00+07:00"
draft = false
tags = ["bash", "cli", "claude-code"]
description = ""
+++

## The problem

If your Claude Code (or other AI coding agent) keeps getting errors like these when running bash commands:

```
stty: stdin isn't a terminal
bind: warning: line editing not enabled
```

It's because your shell profile contains commands that only work in interactive shells.

## The fix

Guard interactive-only commands with `[[ $- == *i* ]]`:

```bash
# One-liners
[[ $- == *i* ]] && stty -ixon
[[ $- == *i* ]] && bind '"\C-s": forward-search-history'

# Multiple commands
if [[ $- == *i* ]]; then
    stty -ixon
    bind '"\C-s": forward-search-history'
    bind '"\C-r": reverse-search-history'
fi
```

The `$-` variable contains current shell options. If it includes `i`, the shell is interactive. This is better than checking for specific tool environment variables - it works for any non-interactive invocation (scripts, cron, CI/CD).

## Why does this happen?

### ~/.bashrc vs ~/.bash_profile

- `~/.bash_profile` runs for **login shells** - one-time setup like `PATH` and environment variables
- `~/.bashrc` runs for **interactive non-login shells** - aliases, prompt, functions

Best practice is to source `~/.bashrc` from `~/.bash_profile` and put everything in `~/.bashrc`:

```bash
# ~/.bash_profile
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
```

### macOS specifics

On macOS, Terminal.app and iTerm2 open **login shells** by default, so they run `~/.bash_profile`. This is opposite to most Linux terminals which run `~/.bashrc`. That's why many macOS users put everything in `~/.bash_profile` - it works for them, but breaks non-interactive tools.

### Why Claude Code sources your profile

Claude Code starts its shell as a **login shell** (`-l` flag) to get access to your `$PATH`, environment variables, and tools like nvm, pyenv, cargo, etc. This means it sources `~/.bash_profile` (and `~/.bashrc` if sourced from it). But unlike Terminal.app, Claude Code's shell is non-interactive - so `stty`, `bind`, and similar commands fail.
