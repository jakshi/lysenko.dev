+++
date = "2014-01-25T18:57:00+07:00"
description = ""
draft = false
tags = ["git"]
title = "Rewriting your email in git commits"
aliases = ["/post/rewriting-your-email-in-git-commits/"]
+++

Sometimes you need to rewrite your email across all commits in a git repository.

> **Note (2026):** This post originally used `git filter-branch`, which has been deprecated since Git 2.24. The modern equivalent is [`git filter-repo`](https://github.com/newren/git-filter-repo). The `filter-branch` command below still works but is no longer recommended.

<!--more-->

## With git filter-branch (deprecated)

```bash
git filter-branch --env-filter '
  if [ $GIT_AUTHOR_EMAIL = bad@email ]; then
    GIT_AUTHOR_EMAIL=correct@email
  fi
  export GIT_AUTHOR_EMAIL
'
```

## Modern equivalent: git-filter-repo

```bash
pip install git-filter-repo
git filter-repo --email-callback '
  return email if email != b"bad@email" else b"correct@email"
'
```

## For collaborators

After a history rewrite, collaborators need to react. Per [Jakub Narębski](http://stackoverflow.com/users/46058/jakub-narebski):

- If they didn't base any work on pre-rewrite history: `git reset --hard origin/master` or `git pull origin` (fast-forward).
- If they did base work on it: `git rebase origin/master` or `git pull --rebase origin`.

## References

- [git-filter-repo](https://github.com/newren/git-filter-repo)
- [Stack Overflow: Rewrite author in history](http://stackoverflow.com/questions/3401732/rewrite-author-in-history)
- [Pro Git: Rewriting History](http://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)
