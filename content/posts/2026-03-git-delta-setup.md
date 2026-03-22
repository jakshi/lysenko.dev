+++
title = "Delta - Better Git Diffs in Terminal"
date = "2026-03-22T10:00:00+07:00"
draft = false
tags = ["git", "cli", "tools"]
description = ""
+++

[Delta](https://github.com/dandavison/delta) is a pager for git diffs that adds side-by-side view, syntax highlighting, line numbers, and clickable hyperlinks to files.

```bash
brew install git-delta
```

![Delta side-by-side diff screenshot](/img/git-delta-screenshot.png)

## My global git config

```ini
[interactive]
    diffFilter = delta --color-only

[delta]
    features = side-by-side line-numbers decorations hyperlinks navigate
    whitespace-error-style = 22 reverse

[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none
```

The `navigate` feature lets you jump between files with `n` and `N` in the pager.

## Git alias for delta

I use a `dd` alias that pipes `git diff` through delta:

```ini
[alias]
    dd = "!git diff \"$@\" -- | delta #"
```

The trailing `#` is important — without it, git appends extra args at the end of the command, and delta interprets them as its own flags. The `#` comments those out so only `git diff` receives the arguments.

This lets you do:

```bash
git dd            # unstaged changes
git dd --staged   # staged changes
git dd HEAD~3     # last 3 commits
```

https://github.com/dandavison/delta
