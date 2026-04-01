+++
title = "The Elements of Style Plugin for Claude Code"
date = "2026-04-01T10:00:00+07:00"
draft = false
tags = ["ai", "cli", "tools", "claude", "writing"]
description = ""
+++

Claude Code writes prose. Blog posts, commit messages, PR descriptions, documentation — all text that humans read. Without guidance, AI-generated prose drifts toward filler, passive voice, and hedging. You get "it should be noted that" instead of a direct statement.

Jesse Vincent's [The Elements of Style](https://github.com/obra/the-elements-of-style) plugin fixes this. It packages Strunk's 1918 writing rules as a Claude Code skill.

## Who made it

Jesse Vincent (obra on GitHub) created the [Superpowers](https://github.com/obra/superpowers) framework for building Claude Code plugins. He also co-founded [Keyboardio](https://www.keyboardio.com/). He [wrote about](https://blog.fsck.com/2025/10/13/this-one-weird-trick-makes-the-ai-a-better-writer/) why he made this plugin: feeding Strunk's guide to Claude before writing produced output roughly 30% shorter and stylistically sharper. The same teaching method that worked for him personally now works for the AI.

## What it does

The plugin provides a single skill: `elements-of-style:writing-clearly-and-concisely`. When invoked, Claude reads a ~12,000-token reference containing Strunk's rules and applies them to whatever prose it writes. That's a noticeable chunk of context, but the skill handles this: when context is tight, it dispatches a subagent for copyediting instead of loading the full reference into the main conversation.

The rules are concrete:

- Use active voice
- Omit needless words
- Put emphatic words at the end of a sentence
- Put statements in positive form
- Use definite, specific, concrete language

These are not vague suggestions. The reference includes examples of what to cut and why. Claude follows them because they appear in context as explicit instructions.

## Install

The original repo lacks a `marketplace.json`, so you cannot install it via `/plugin marketplace add obra/the-elements-of-style`. I [forked it](https://github.com/jakshi/the-elements-of-style) and added the missing file.

Install from the fork:

```
/plugin marketplace add jakshi/the-elements-of-style
/plugin install elements-of-style@elements-of-style-marketplace
/reload-plugins
```

## Usage

Two ways to invoke it:

1. Run `/elements-of-style:writing-clearly-and-concisely` before asking Claude to write something.
2. Just ask Claude to use the style skill — it will pick it up from the available skills list.

I use it before writing blog posts and documentation. The difference shows up in tighter sentences and fewer weasel words.

## Links

- Original: https://github.com/obra/the-elements-of-style
- Fork with marketplace.json: https://github.com/jakshi/the-elements-of-style
- Jesse's blog post: https://blog.fsck.com/2025/10/13/this-one-weird-trick-makes-the-ai-a-better-writer/
