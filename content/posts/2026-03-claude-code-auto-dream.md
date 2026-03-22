+++
title = "Claude Code Auto-Dream - Background Memory Consolidation"
date = "2026-03-22T14:00:00+07:00"
draft = false
tags = ["ai", "cli", "tools", "claude"]
description = ""
+++

I was poking around Claude Code's `/memory` command and noticed a toggle: "auto-dream: off". What is that?

## What is Auto-Dream?

It's a background memory consolidation feature. Between your sessions, Claude Code spawns a "DreamTask" subagent that:

- Reads your recent session transcripts
- Reviews existing memories for staleness
- Merges new signal, prunes contradictions
- Converts relative dates to absolute
- Keeps `MEMORY.md` index updated

It's read-only during dreaming — Bash is restricted so it can't modify your code. Just memory housekeeping.

## How to enable

It's off by default (gated behind a feature flag). I found the setting in [this Reddit screenshot](https://www.reddit.com/media?url=https%3A%2F%2Fpreview.redd.it%2Fwhat-is-this-auto-dream-feature-v0-9s5nkxwplfqg1.png%3Fwidth%3D2838%26format%3Dpng%26auto%3Dwebp%26s%3D17645238c869750376dd36ce38cfbf012c66933f).

Add to `~/.claude/settings.json`:

```json
{
  "autoDreamEnabled": true
}
```

You can verify it's on by running `/memory` — it should show "auto-dream: on".

## Does it work?

I tried it — within minutes it consolidated my past sessions into organized memory files. User profile, workflow preferences, project status, image handling rules — all auto-magically extracted from past conversations.

A bit like actual dreaming — it processes what happened while you're not looking, and the memories are just there next time you start a session.
