+++
date = "2026-05-26T16:30:00+07:00"
description = ""
draft = false
tags = ["cli", "ai", "llm", "tools", "google"]
title = "Google Recently Achieved AGY"
+++

Or rather — `agy`, the binary name for the new [Antigravity CLI](https://antigravity.google/product/antigravity-cli). Cunning move from Google. I like it.

At I/O 2026 (May 19) Google announced the Antigravity 2.0 platform, which includes the new CLI. Gemini CLI becomes a secondary product and moves to usage-based pricing. Versions: platform 2.0, CLI binary 1.0.2.

<!--more-->

## Install

```bash
brew install --cask antigravity-cli
agy
```

![agy startup screen](/img/agy-screenshot.jpg)

## What I liked after a quick spin

**It's written in Go.** The old Gemini CLI was Node-based; the new one is a single Go binary. Snappier startup, lower memory. There's an opinion — not a Google claim — that Go is more supply-chain-resilient: no install-time scripts in the module system, and a rich standard library and community style that keep transitive dependency graphs small.

**Modern conventions are first-class.** MCP servers via `/mcp` and `mcp_config.json`. Skills via `/skills`. If you have already invested in those for Claude Code or another agent, the muscle memory carries over.

**Generous free tier.** A regular Google account works — no paid subscription required. Paid tiers (AI Pro, Ultra, Gemini Code Assist) raise the limits, but the free tier is enough to take it for a real spin.

**Both Gemini and Opus are available.** That surprised me — after a single Google auth, Claude Opus appeared as a model option. In my experience Gemini tends to be more stubborn and Opus more agreeable, so having both and switching by task is useful.

Side benefit: out of Claude Code tokens mid-task? Continue in `agy`.

## References

- Product page: <https://antigravity.google/product/antigravity-cli>
- Docs: <https://antigravity.google/docs/command>
