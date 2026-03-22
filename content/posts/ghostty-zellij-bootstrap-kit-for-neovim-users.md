+++
date = "2026-03-22T13:00:00+07:00"
description = "A practical guide to setting up Ghostty + Zellij on macOS without losing your mind over keybinding conflicts"
draft = false
tags = ["zellij", "ghostty", "neovim", "terminal", "macos", "how-to"]
title = "Ghostty + Zellij bootstrap kit for Neovim users on macOS"

+++

# The setup

I recently switched to [Zellij](https://zellij.dev/) as my terminal multiplexer and [Ghostty](https://ghostty.org/) as my terminal emulator. Both are excellent, but getting them to play nicely together on macOS — especially as a Neovim user — required solving a few keybinding headaches.

Here's everything I learned so you don't have to.

<!--more-->

## Ghostty config

Location: `~/Library/Application Support/com.mitchellh.ghostty/config`

If you use Zellij, you likely have this in your Ghostty config:

```
macos-option-as-alt = true
```

This makes the Option key behave as Alt, which Zellij needs for its keybindings (`Alt+h`, `Alt+j`, etc.). But it comes with a nasty side effect.

## The Alt+Arrow trap

With `macos-option-as-alt = true`, Ghostty still has built-in macOS keybindings that convert:

- `Option+Right` -> `ESC+f` (forward word)
- `Option+Left` -> `ESC+b` (backward word)

Zellij receives `ESC+f` and interprets it as `Alt+f`. If you have `Alt+f` bound to `ToggleFloatingPanes` (the Zellij default), pressing `Option+Right` will randomly pop open a floating pane instead of jumping forward a word in the shell.

I spent a while debugging this one.

### The fix

Rebind `ToggleFloatingPanes` from `Alt f` to `Alt Shift f` in your Zellij config:

```kdl
bind "Alt F" { ToggleFloatingPanes; }
```

Now `Option+Right` passes through as word-forward, and `Alt+Shift+f` toggles floating panes. No conflicts.

You should also remove `Alt left` and `Alt right` bindings from Zellij if you have them — they'll conflict with word navigation for the same reason.

## Essential keybinding tweaks

Zellij's defaults are good but a few additions make life easier:

### New tab shortcut

There's no single-key shortcut for creating a new tab. The default is `Ctrl+t`, then `n` (enter Tab mode, then press n). I added a direct shortcut:

```kdl
shared_except "locked" {
    bind "Alt N" { NewTab; SwitchToMode "normal"; }
}
```

`Alt+Shift+n` creates a new tab instantly, mirroring `Alt+n` which creates a new pane.

### Tab navigation

No `Alt+1`, `Alt+2` tab switching by default either. You can add those, but honestly `Alt+h` / `Alt+l` to move between tabs is good enough.

## Plugins worth installing

### zellij-autolock

This one is a must for Neovim users. It automatically locks Zellij when Neovim (or vim, git, fzf, etc.) is running in the focused pane. This means Zellij keybindings won't interfere with your editor.

Add to your `plugins` block:

```kdl
plugins {
    autolock location="https://github.com/fresh2dev/zellij-autolock/releases/latest/download/zellij-autolock.wasm" {
        is_enabled true
        triggers "nvim|vim|avim|git|fzf|zoxide|atuin"
        reaction_seconds "0.3"
    }
}
```

Note: I use multiple Neovim configs (e.g. `avim`), so I added those to the triggers list as well. Add any custom Neovim wrappers you use.

And load it on startup:

```kdl
load_plugins {
    autolock
}
```

### zellij-forgot

Can't remember your keybindings? Press `Ctrl+y` and fuzzy-search them.

```kdl
shared_except "locked" {
    bind "Ctrl y" {
        LaunchOrFocusPlugin "https://github.com/karimould/zellij-forgot/releases/latest/download/zellij_forgot.wasm" {
            floating true
            "LOAD_ZELLIJ_BINDINGS" "true"
        }
    }
}
```

It auto-loads your actual keybindings from the config. Very handy while you're still building muscle memory.

## Quick reference

| Action | Keybinding |
|---|---|
| New pane | `Alt+n` |
| New tab | `Alt+Shift+n` |
| Toggle floating pane | `Alt+Shift+f` |
| Switch pane/tab left | `Alt+h` |
| Switch pane/tab right | `Alt+l` |
| Move pane up/down | `Alt+j` / `Alt+k` |
| Tab mode | `Ctrl+t` |
| Pane mode | `Ctrl+p` |
| Resize mode | `Ctrl+n` |
| Forgot keybindings | `Ctrl+y` |
| Lock/unlock | `Ctrl+g` |
| Word forward (shell) | `Option+Right` |
| Word backward (shell) | `Option+Left` |

## Ctrl+o conflict

Zellij uses `Ctrl+o` for Session mode, but so does Neovim (jump list) and Claude Code. Autolock handles the Neovim case, but for other tools you have two options:

1. Rebind Zellij's Session mode to `Ctrl+Shift+o`:

```kdl
// In session block:
bind "Ctrl O" { SwitchToMode "normal"; }

// In shared_except block:
bind "Ctrl O" { SwitchToMode "session"; }
```

2. Or add the conflicting tool to autolock triggers (e.g. `"nvim|vim|avim|claude|git|fzf|zoxide|atuin"`).

## TL;DR

1. You probably already have `macos-option-as-alt = true` in Ghostty — it's needed for Zellij's Alt keybindings
2. Rebind Zellij's `Alt f` to `Alt Shift f` to fix the Option+Arrow conflict
3. Remove `Alt left` / `Alt right` bindings from Zellij
4. Install `zellij-autolock` — it's essential for Neovim users
5. Install `zellij-forgot` while you're learning the keybindings
6. Add `Alt+Shift+n` for quick tab creation
7. Rebind `Ctrl+o` (Session mode) to `Ctrl+Shift+o` if it conflicts with your tools
