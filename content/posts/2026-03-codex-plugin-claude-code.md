+++
title = "Codex Plugin for Claude Code - OpenAI as a Subagent"
date = "2026-03-31T14:00:00+07:00"
draft = false
tags = ["ai", "cli", "tools", "claude", "codex"]
description = ""
+++

[codex-plugin-cc](https://github.com/openai/codex-plugin-cc) is an OpenAI plugin that brings Codex CLI into Claude Code as a set of slash commands. A second AI opinion without switching tools.

## Install

You need a ChatGPT subscription (Free tier works) or an OpenAI API key.

```bash
brew install codex
codex login
```

Then inside Claude Code:

```
/plugin marketplace add openai/codex-plugin-cc
/plugin install codex@openai-codex
/reload-plugins
/codex:setup
```

## Commands

| Command | What it does |
|---|---|
| `/codex:review` | Code review of staged or recent changes |
| `/codex:adversarial-review` | Harder review — finds edge cases and security issues |
| `/codex:rescue` | Delegates a task or investigation to Codex |
| `/codex:status` | Checks if a background Codex task is still running |
| `/codex:result` | Fetches the output of a completed task |
| `/codex:cancel` | Kills a running Codex task |

The review commands are fire-and-forget. You kick them off, keep working, and check `/codex:result` when ready.

## Sandbox restrictions

I wanted to use `/codex:rescue` to read an image outside the repo. It refused. I dug into the source and found why.

Line 460 of `codex-companion.mjs`:

```javascript
sandbox: request.write ? "workspace-write" : "read-only"
```

The plugin hardcodes sandbox to either "read-only" or "workspace-write". Both modes restrict file access to the working directory. No exceptions, no config flag.

Codex CLI itself supports broader access. You can run `codex exec -s danger-full-access` or pass `-c 'sandbox_permissions=["disk-full-read-access"]'` for full disk reads, and `-i` to attach images. The plugin exposes none of this.

This restriction is intentional. The plugin runs every task with `approvalPolicy: "never"` — full auto, no human in the loop. Tight sandboxing compensates for the lack of approval prompts. Reasonable tradeoff.

## Takeaway

The plugin turns Codex into a background worker you can dispatch from Claude Code. Reviews run in parallel while you keep coding. The sandbox is strict by design, so keep your target files inside the repo.

https://github.com/openai/codex-plugin-cc
