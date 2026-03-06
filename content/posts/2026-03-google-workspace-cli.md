+++
title = "gws - Google Workspace CLI with AI Agent Support"
date = "2026-03-06T10:00:00+07:00"
draft = false
tags = ["cli", "tools", "google", "ai"]
description = ""
+++

[gws](https://github.com/googleworkspace/cli) is a Google Workspace CLI built with AI agents in mind. Written in Rust by [Justin Poehnelt](https://github.com/jpoehnelt), a Developer Relations Engineer at Google (not an official Google product though).

What sets it apart:

- **40+ AI agent skills** — pre-built skills for Gmail, Drive, Docs, Calendar, Sheets
- **MCP server** — `gws mcp -s drive,gmail,calendar` exposes Workspace APIs to Claude, VS Code, and other MCP clients
- **Prompt injection scanning** — can scan API responses through Google's Model Armor before feeding them to LLMs (`--sanitize` flag)
- **Dynamic API discovery** — reads from Google's Discovery Service at runtime, no static command lists to update

It also works as a regular CLI for Drive, Gmail, Calendar, Sheets, Docs, Chat, Admin and more — all responses are JSON, easy to pipe into `jq`.

## Install

```bash
brew install googleworkspace-cli
```

## Auth

If you have gcloud configured, setup is simple:

```bash
gws auth setup
```

## Usage

```bash
gws drive files list --params '{"pageSize": 10}'
gws gmail users messages list --params '{"userId": "me", "maxResults": 5}'
gws calendar events list --params '{"calendarId": "primary"}'
```

## Alternative

A simpler alternative without the AI agent features is [gogcli](https://github.com/steipete/gogcli).

https://github.com/googleworkspace/cli
