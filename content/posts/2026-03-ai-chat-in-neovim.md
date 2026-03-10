+++
title = "AI Chat in Neovim with CodeCompanion"
date = "2026-03-07T10:00:00+07:00"
draft = false
tags = ["neovim", "ai", "tools", "vim"]
description = ""
+++

I went looking for a good AI chat plugin for Neovim (AstroNvim specifically) — something that lets me ask questions about the codebase, get inline edits, and generate commands without leaving the editor.

## What I tried

### opencode.nvim

[opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) looked promising, but felt rough around the edges. To ask a simple question I had to: `<Leader>On` → `i` → type the prompt → `Ctrl-\ Ctrl-n` → `Ctrl-w w`. Some interface lines were visually broken too. I'm sure it could all be configured and fixed, but I wanted something that just works.

### CodeCompanion.nvim

[CodeCompanion.nvim](https://github.com/olimorris/codecompanion.nvim) just worked. Chat, inline edits, command generation — all out of the box with minimal config.

## Installing CodeCompanion in AstroNvim

### 1. Add the community module

In `lua/community.lua`:

```lua
---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.editing-support.codecompanion-nvim" },
}
```

### 2. Configure the adapter

Create `lua/plugins/codecompanion.lua`. CodeCompanion supports API-key-based adapters (OpenAI, Anthropic) and subscription-based ones (GitHub Copilot, Claude Code, Gemini CLI).

Here's an example using GitHub Copilot with Claude Sonnet 4.6:

```lua
---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = { adapter = { name = "copilot", model = "claude-sonnet-4.6" } },
        inline = { adapter = { name = "copilot", model = "claude-sonnet-4.6" } },
        cmd = { adapter = { name = "copilot", model = "claude-sonnet-4.6" } },
      },
    },
  },
}
```

The three strategies control which adapter/model is used for:

- **chat** — conversational AI in a split buffer
- **inline** — AI edits code directly in your current buffer
- **cmd** — AI generates Neovim commands

### 3. Install and authenticate

Run `:Lazy sync` in Neovim.

If using the Copilot adapter, make sure you're authenticated with GitHub Copilot (requires an active Copilot Pro subscription). Run `:Copilot setup` if you have copilot.vim or copilot.lua installed.

### 4. Usage

| Keys | Action |
|---|---|
| `<Leader>Ac` | Toggle chat |
| `<Leader>Aq` | Inline assistant |
| `<Leader>Ap` | Action palette |

## Subscription-based adapters

Not everything requires a separate API key. These adapters reuse existing subscriptions:

| Adapter | Subscription |
|---|---|
| copilot | GitHub Copilot Pro |
| claude_code | Claude Pro |
| gemini_cli | Gemini Pro |
| mistral_vibe | Mistral Le Chat Pro |

---

For those enlightened people who use Neovim — what do you use for AI chat?

- https://github.com/olimorris/codecompanion.nvim
- https://github.com/nickjvandyke/opencode.nvim
