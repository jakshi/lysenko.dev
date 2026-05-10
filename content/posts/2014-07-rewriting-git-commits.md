+++
date = "2014-07-14T00:13:00+07:00"
description = ""
draft = false
tags = ["git"]
title = "Rewriting a git commit"
aliases = ["/post/rewriting-git-commit/"]
+++

Sometimes you commit something nasty and need to rewrite it. Or split a commit into parts. Or whatever.

Use case: you want to remove some files from a commit you already made.

<!--more-->

## Find the commit

```bash
git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
```

Say it's `4ca80f0`.

## Remove files from the commit

```bash
git rebase -i 4ca80f0~1
```

Replace `pick` with `edit` and save the file.

Unstage everything in that commit:

```bash
git reset HEAD^
```

Now all files are back to pre-commit state. Add, remove, or stage as needed.

To undo changes to a tracked file:

```bash
git checkout -- windows
```

For a new file, just delete it:

```bash
rm -rf windows
```

You can also split this into several commits.

## Change the commit message

```bash
git commit --amend
```

## Apply the rewrite

```bash
git rebase --continue
```

## References

- [Stack Overflow: How do I selectively revert some changes in a single commit to a single file?](http://stackoverflow.com/questions/11729030/how-do-i-selectively-revert-some-changes-in-a-single-commit-to-a-single-file)
- [Stack Overflow: Reverting part of a commit with git](http://stackoverflow.com/questions/4795600/reverting-part-of-a-commit-with-git/4796144#4796144)
