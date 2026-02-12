+++
title = "gogcli - Manage Your Google Account from CLI"
date = "2025-02-12T10:00:00+07:00"
draft = false
tags = ["cli", "llm", "ai", "tools", "google"]
description = ""
+++

I recently found an interesting tool - [gogcli](https://github.com/steipete/gogcli) - CLI tool to manage your Google account: Gmail, Calendar, Drive, Docs, Sheets, Contacts, Tasks and more.

What makes it interesting - you can use it with AI Agents: JSON-first output, least-privilege auth (--readonly, per-service scopes), command allowlisting for sandboxed agent environments.

Examples of what you can ask Claude Code to do with it:

* point to a directory with business card photos and ask to add those to your Google Contacts
* read an email thread and create a calendar meeting from it
* summarize unread emails from the last 24 hours

The flip side of good access control - auth setup is a bit involved, you need to create your own GCP project/app with OAuth credentials. If you've never done that before, let Claude Code or Codex walk you through it.
