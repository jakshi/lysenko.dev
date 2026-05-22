+++
date = "2026-05-22T11:00:00+07:00"
description = ""
draft = false
tags = ["ai", "claude-code", "debugging", "floci"]
title = "Tell your AI agent to read the code, not the docs"
+++

A trick from my friend Paul Tobias. Changed how I debug unfamiliar tools.

<!--more-->

Reading source code was expensive. Open the repo, hunt for the right file, trace a call chain, lose an hour. So we read docs instead. Docs were the shortcut.

An AI agent removes the cost. Grepping a cloned repo takes seconds. The agent finds the handler, follows the path, and quotes the line back. Reading code is now cheaper than reading docs.

I tried it last week while testing [Floci](https://github.com/floci-io/floci) and [Fakecloud](https://github.com/faiscadev/fakecloud) as LocalStack alternatives. I wanted to know their limits — which endpoints are full, which are stubs, which quietly no-op.

So I cloned both repos and told the agent: *Source is the source of truth. Check it before you claim anything.*

Different agent after that. Straight to handler files, back with answers like "this endpoint is a stub" or "header parsed but ignored." Specific. Verifiable. Often pointing at a line number.

The shift: docs describe intent, code describes what shipped. When reading code was expensive, docs were the right reference. Now that reading code is cheap, code is. Remember to tell the agent.
