+++
title = "One Rule to Make AI in Your Editor Actually Useful"
date = "2026-03-04T10:00:00+07:00"
draft = false
tags = ["zed", "ai", "tools", "productivity"]
description = ""
+++

When I want to actually write code (as opposed to generating it with Claude Code), I use [Zed](https://zed.dev). It's fast, has great Vim mode, cool themes, devcontainers, a debugger, an AI agent — all in one place.

But one thing was making me sour: every time I asked the AI agent a small clarification about the codebase, it would bomb me with two pages of explanations and code samples. That really pushed me out of the flow.

Then I added one rule to Zed's default assistant instructions (Settings > Default Rules — same idea as `CLAUDE.md` for Claude Code):

> You are a concise assistant. Answer in 2–3 short sentences. When code is helpful, prefer small focused examples. Ask clarifying questions only when necessary.

And now coding feels like a flow again.

Not a silver bullet, but a good trick when you need a coding assistant / co-pilot, not a code generator.
