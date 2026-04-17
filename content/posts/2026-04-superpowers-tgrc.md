+++
title = "Trying Superpowers on a Small Project"
date = "2026-04-17T10:00:00+07:00"
draft = false
tags = ["ai", "claude", "rust", "cli", "tools"]
description = ""
+++

I wanted to try [Superpowers](https://github.com/obra/superpowers) — Jesse Vincent's plugin framework that promises a structured workflow for Claude Code. To get a real taste, I needed a small but useful project, not a toy.

The use case was already there. For years I've thrown useful links into Telegram saved messages — a personal bookmark dump that grew unmanageable. I wanted Claude Code to help me sort through it. None of the existing Telegram CLIs looked maintained or friendly enough to wire in. So I'd build one. Two birds, one project.

A few sessions later, I had `tgrc` — a CLI that reads Telegram messages from the terminal. It handles authentication (including 2FA), lists chats, reads messages with pagination, and ships via Homebrew. About 700 lines of Rust across four source files, built on [TDLib](https://github.com/tdlib/td) via the [tdlib-rs](https://github.com/FedericoBruzzone/tdlib-rs) crate.

![tgrc reading saved messages](/img/tgrc-screenshot.jpg)

## Skill detection

Superpowers promises that skills trigger automatically — the README states the agent checks for relevant skills before every task. In practice, only the obviously-named ones fired on their own:

- `using-superpowers` at session start — establishes how skills work, reliable.
- `requesting-code-review` when I asked "aren't there specific skills for code reviews?" — Claude recognized the match.

Both cases where my message essentially named what I wanted. The plugin also ships skills for `brainstorming`, `writing-plans`, `test-driven-development`, `systematic-debugging`, and `dispatching-parallel-agents`. None of these activated on their own — even when they clearly applied. I wrote config tests after the implementation, not before. I built from a pre-existing plan without revisiting requirements. The Homebrew install crashed with `dyld: Library not loaded` and Claude diagnosed it correctly, but no structured debugging workflow kicked in.

There's a pattern here. The skills that fire are tied to outcomes — review, write, build. The skills that don't fire are tied to process — brainstorm, plan, test first. When you ask for an outcome, the framework has nothing to match a process skill against.

## Layered code reviews

Code reviews were where the experience paid off. I explicitly invoked three:

- `superpowers:code-reviewer` — design-level review of the whole CLI
- `codex:review` — implementation-focused (separate plugin, not Superpowers, but in the toolbox)
- `codex:adversarial-review` — actively tried to break things

Together they found six real bugs:

- `exit(0)` on errors — `read` and `list` printed error messages but exited successfully, breaking script use
- 2FA password retry hung silently on wrong input instead of re-prompting
- Email auth states fell through a catch-all `_ => {}` and hung
- `logout` only deleted local files, leaving the Telegram session active server-side
- Timestamps displayed as UTC instead of local timezone
- `unsafe` blocks missing `// SAFETY:` comments

The kind of bugs you miss because you wrote the code yourself. A single review pass would have surfaced some. Three layered passes — design, implementation, adversarial — surfaced more.

## Trust but verify

The adversarial review also confidently flagged an off-by-one in `--skip` pagination, claiming it produced duplicate messages. Before fixing, I asked Claude to verify. We tested manually — no overlap. The review was wrong.

AI reviewers can be confidently wrong, especially adversarial ones whose job is to find problems. Always verify findings before applying fixes.

## What I'd do differently

Next time I'll invoke the process skills explicitly — start with `brainstorming` before anything else.

The dyld crash on Homebrew install shows why. After publishing the formula, the binary crashed with `dyld: Library not loaded` — it linked dynamically against `libtdjson` at the CI build path. Fixable — bump `tdlib-rs` to 1.4 and enable the `static` feature — but the kind of thing brainstorming would have caught before I wrote a line. "How will users install this?" leads directly to "the binary needs to be self-contained."

## Closing

Treating Superpowers skills like CLI tools — know what's in your toolbox, invoke explicitly — worked better for me than trusting auto-detection. That's what I'll try on the next project: brainstorm first, plan first, then build.

[Superpowers on GitHub](https://github.com/obra/superpowers).
