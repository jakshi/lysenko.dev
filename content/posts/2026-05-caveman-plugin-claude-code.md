+++
date = "2026-05-10T15:00:00+07:00"
description = ""
draft = false
tags = ["claude-code", "tools", "ai-coding", "llm"]
title = "Trimming the chatter from Claude Code with the caveman plugin"
+++

Most LLM answers come wrapped in throat-clearing. "Sure! I'd be happy to help. The reason your component re-renders is most likely..." By the time the useful sentence arrives, I've read four lines of nothing.

The cost is mental load, not just dollars. Every reply forces me to skim past pleasantries for the answer. Across a session, the skimming compounds into fatigue.

<!--more-->

I've been running [caveman](https://github.com/JuliusBrussee/caveman) in Claude Code for a few weeks. It flips the agent into telegraphic mode: same technical content, no filler.

## Before and after

> **Normal.** "The reason your React component is re-rendering is likely because you're creating a new object reference on each render cycle. When you pass an inline object as a prop, React's shallow comparison sees it as a different object every time, which triggers a re-render. I'd recommend using useMemo to memoize the object."

> **Caveman.** "New object ref each render. Inline object prop = new ref = re-render. Wrap in `useMemo`."

Same fix. The second reads in five seconds.

## Install

```bash
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman
```

Trigger with `/caveman`. Switch level with `/caveman lite|full|ultra`. Turn off by saying `stop caveman` or `normal mode`.

## Brevity buys more than tokens

A March 2026 paper, *Brevity Constraints Reverse Performance Hierarchies in Language Models* (Hakim, [arXiv:2604.00025](https://arxiv.org/abs/2604.00025)), found that constraining LLMs to brief responses improved accuracy by 26 percentage points on certain benchmarks, and shrank the gap between small and large models by up to two-thirds. Verbose isn't always better.

## When it earns its keep

Useful:

- **Coding sessions.** Bug → diagnosis → fix, no preamble.
- **Routine automation.** Renames, tests, small refactors. The model's explanation rarely matters; caveman trims it without changing the diff.
- **Reviews and commits.** `/caveman-review` and `/caveman-commit` produce one-line PR comments and tight conventional commits.

Less useful:

- **Brainstorming and exploration.** Here the hedging *is* the value.
- **Research and learning.** Explanatory prose is the point.

On for execution, off for thinking.

## The token bonus

Project benchmarks: ~65% output-token reduction across ten coding prompts (range 22–87%). Real money on heavy usage. For me, smaller than the readability win — but I'll take both.

## Closing

Repo: https://github.com/JuliusBrussee/caveman

If your agent sounds like a customer-service rep who took a writing class, try it. Turn it off when you want it to think out loud.
