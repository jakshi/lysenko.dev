+++
date = "2026-06-24T10:00:00+07:00"
description = ""
draft = false
tags = ["ai", "llm", "macos", "cli", "tools"]
title = "macOS 26 ships a local 3B LLM — and you can actually use it"
+++

If you run macOS 26 Tahoe on Apple Silicon, you already have a language model on disk. Apple ships a ~3-billion-parameter model with the OS and exposes it through the [FoundationModels](https://developer.apple.com/documentation/FoundationModels) framework — the same model Apple Intelligence runs on. It's heavily quantized — Apple uses 2-bit quantization-aware training (QAT) — runs locally, and costs nothing.

The catch: the API is Swift only. You can't curl it.

<!--more-->

[apfel](https://github.com/Arthur-Ficial/apfel) fixes that. It wraps the built-in model in a CLI and an OpenAI-compatible server, so anything that speaks the OpenAI API can talk to your Mac's local model — no keys, no cloud, no Xcode.

## Install

```bash
brew install apfel
```

Needs macOS 26 Tahoe or later and an Apple Silicon Mac (M1+). The model is part of the OS, so there's nothing to download.

## Use it

One-shot from the shell:

```bash
apfel "What is the capital of Austria?"
```

![apfel writing a haiku, fully offline](/img/apfel-screenshot.jpg)

Interactive chat:

```bash
apfel --chat
```

OpenAI-compatible server:

```bash
apfel --serve   # http://localhost:11434/v1
```

The server is the part that matters. Point any OpenAI SDK at the local endpoint:

```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:11434/v1", api_key="not-needed")

resp = client.chat.completions.create(
    model="apple-foundationmodel",
    messages=[{"role": "user", "content": "Summarize this in one line: ..."}],
)
print(resp.choices[0].message.content)
```

`/v1/chat/completions` supports streaming, tool calling, and JSON-schema output. `/v1/models` lists the one model you get.

## Where it fits

It's a 3B model with a 4096-token context — input and output combined. That budget rules out AI-agent workloads and long documents. But for summarization, entity extraction, classification, short rewrites, and quick local glue in scripts, it's free, private, and already installed. No token meter running.

Repo: https://github.com/Arthur-Ficial/apfel
