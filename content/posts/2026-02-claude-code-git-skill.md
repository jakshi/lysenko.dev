+++
title = "Claude Code Git Skill - Teaching AI to Not Destroy Your Repo"
date = "2026-02-22T10:00:00+07:00"
draft = false
tags = ["claude-code", "git", "ai", "skills"]
description = ""
+++

Once upon the time Claude Code wiped whole git repo of my side project, cleaned up orphaned references, and force pushed to remote - no second thoughts.

Then I restored it from backup and wrote a [Claude Code skill](https://docs.claude.com/en/docs/claude-code/skills) - a safety checklist that triggers before any dangerous git operation (`git reset --hard`, `git push --force`, `git rebase`, `git clean -fd`, `git branch -D`):

1. Back up the repo: `cp -r .git .git-backup-$(date +%Y%m%d-%H%M%S)`
2. Work in a separate worktree when possible
3. Prefer `--force-with-lease` over `--force`
4. Know your escape hatch: `git reflog`

May be Anthropic should add a dedicated git tool to Claude Code with proper guardrails - confirmation prompts for destructive commands, automatic backups before history-rewriting operations.

It seems too dangerous to treat git as one more bash command.
