+++
title = "My Entire Git Config, Explained"
date = "2026-04-11T10:00:00+07:00"
draft = false
tags = ["git", "cli", "tools"]
description = ""
+++

My git config grew over years — an alias here, a setting there. After a recent round of improvements I decided to write up the current state: the whole config, then the story behind each section.

## The config

```ini
[user]
    email = kostiantyn@lysenko.dev
    name = Kostiantyn Lysenko
    signingkey = 9130673A           # GPG key for signed commits

[core]
    autocrlf = false                # leave line endings alone
    ignorecase = false              # respect exact filename casing
    excludesfile = ~/.gitignore     # global gitignore for OS artifacts
    fsmonitor = true                # filesystem watcher — faster git status
    untrackedCache = true           # cache untracked files between runs

[diff]
    algorithm = histogram           # cleaner diffs than default Myers
    colorMoved = plain              # distinct color for moved lines
    mnemonicPrefix = true           # w/ i/ c/ instead of a/ b/
    renames = true                  # detect file renames

[interactive]
    diffFilter = delta --color-only

[delta]
    features = side-by-side line-numbers decorations hyperlinks navigate
    whitespace-error-style = 22 reverse

[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none

[merge]
    conflictstyle = zdiff3          # three-way conflicts: ours, base, theirs

[push]
    default = simple                # push current branch to same-named upstream
    autoSetupRemote = true          # no more -u origin branch-name
    followTags = true               # push tags with their commits

[fetch]
    prune = true                    # remove stale remote-tracking branches
    pruneTags = true                # remove stale remote tags
    all = true                      # fetch from all remotes

[pull]
    rebase = true                   # rebase by default, keep history linear

[commit]
    verbose = true                  # show diff in commit message editor

[rebase]
    autoSquash = true               # auto-reorder fixup!/squash! commits
    autoStash = true                # stash before rebase, pop after
    updateRefs = true               # move all branches in a stack

[rerere]
    enabled = true                  # remember conflict resolutions
    autoUpdate = true               # stage auto-resolved files

[column]
    ui = auto                       # columnar output when terminal is wide

[branch]
    sort = -committerdate           # most recent branches first

[tag]
    sort = version:refname          # v1.2 before v1.10

[init]
    defaultBranch = main            # match GitHub default

[help]
    autocorrect = prompt            # suggest + confirm mistyped commands

[alias]
    co = checkout
    ci = commit
    st = status
    br = branch
    s = status -s
    hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
    grog = log --graph --abbrev-commit --decorate --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)'
    lg = !serie                     # TUI log viewer
    pull-request = !gh pr create
    dd = "!git diff \"$@\" -- | delta #"
    type = cat-file -t              # what is this object?
    dump = cat-file -p              # show object contents

[filter "lfs"]
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    required = true
    process = git-lfs filter-process

[hub]
    protocol = ssh

[github]
    user = jakshi

[gitget]
    root = ~/git-repos
    host = github.com
    skip-host = true

[color]
    ui = auto
```

## The story

### Diffs that make sense

The default algorithm, Myers, falls apart when code blocks shift around. It marks whole sections as deleted and re-added, even when you only moved a function. Histogram produces diffs that match what actually happened.

`colorMoved` goes further. Moved lines get a distinct color. During review you skip them and focus on real edits.

`mnemonicPrefix` replaces the cryptic `a/` and `b/` in diff headers with `w/` (worktree), `i/` (index), `c/` (commit). You see which side is which at a glance.

I pipe everything through [Delta](https://github.com/dandavison/delta) for side-by-side view, syntax highlighting, and clickable hyperlinks. More on that setup in a [separate post](/posts/2026-03-git-delta-setup/).

### Pushing and fetching

For years I typed `git push -u origin feature-x` on every new branch. `autoSetupRemote` cuts that to `git push`. One flag, one less daily annoyance.

`followTags` pushes annotated tags alongside their commits. I used to forget `git push --tags` after releases. Now tags travel with the code.

On the fetch side, `prune` removes stale remote-tracking branches on every fetch. Delete a branch on GitHub and the local reference disappears. `all` fetches from every remote — useful when you work with forks and keep both `origin` and `upstream`.

### Pulling with rebase

`pull.rebase = true` replays local commits on top of the upstream branch — no merge commits, linear history, easier to read and bisect.

Sometimes you want to preserve the merge point: pulling a release branch into a long-lived integration branch, for example. Override it with `git pull --no-rebase`.

### Rebasing without friction

Three settings turned rebase from a ceremony into a one-liner.

`autoStash` stashes dirty work before a rebase and pops it after. The "cannot rebase: you have unstaged changes" error is gone.

`autoSquash` reorders `fixup!` and `squash!` commits during interactive rebase. Write a fix, run `git commit --fixup <sha>`, rebase, and the fix folds into the right commit.

`updateRefs` I wish I had found sooner. Rebase a stack of branches and Git moves all of them — not just the current one.

### Conflict resolution

`zdiff3` changed how I read merge conflicts. Standard markers show two versions — yours and theirs. `zdiff3` adds the original before either side touched it. With all three visible, each side's intent becomes obvious.

`rerere` — REuse REcorded REsolution — records how you resolve a conflict. Same conflict appears again during a rebase retry or cherry-pick? Git applies your fix and stages the file. Set it once, forget it.

### Sorting and display

Alphabetical branch sorting buries the branch you touched ten minutes ago. `sort = -committerdate` puts recent work on top. Tags sorted by `version:refname` place `v1.2` before `v1.10` — the obvious order Git does not use by default.

`column.ui = auto` lays out `git branch` and `git tag` in columns when the terminal is wide enough.

### Performance

`fsmonitor` and `untrackedCache` work together. Instead of scanning every file on `git status`, Git watches the filesystem and caches untracked file info. On large repos, status drops from hundreds of milliseconds to near-instant. A background daemon makes this possible — skip these two if that bothers you.

### Aliases

The short ones — `co`, `ci`, `st`, `br`, `s` — are muscle memory. I type `git s` dozens of times a day.

`lg` calls [serie](https://github.com/lusingander/serie), a TUI for Git logs. `grog` and `hist` are two flavors of decorated graph logs for when I want the picture in the terminal itself.

`dd` pipes diffs through Delta. The trailing `#` prevents Git from appending extra arguments that Delta would misinterpret.

`type` and `dump` inspect Git objects directly. Rarely needed, handy when debugging.

### Tools

[gitget](https://github.com/grdl/git-get) organizes cloned repos under `~/git-repos` in a clean directory tree. [hub](https://github.com/mislav/hub) and `gh` handle GitHub operations. Git LFS manages large binaries.

## Sources

Inspired by [How Git Core Devs Configure Git](https://blog.gitbutler.com/how-git-core-devs-configure-git) — what the people who build Git actually use.
