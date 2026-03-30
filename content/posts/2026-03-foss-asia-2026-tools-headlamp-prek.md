+++
title = "FOSS Asia 2026 - Two Tools Worth Checking Out"
date = "2026-03-25T10:00:00+07:00"
draft = false
tags = ["conference", "kubernetes", "tools", "foss-asia-2026"]
description = ""
+++

At [FOSS Asia 2026](https://eventyay.com/e/88882f3e) (Mar 8-10, Bangkok), note 9:

Between talks and booths, I discovered two tools new to me.

## Headlamp

[Headlamp](https://headlamp.dev/) is an open-source Kubernetes dashboard — a CNCF Sandbox project under [kubernetes-sigs](https://github.com/kubernetes-sigs/headlamp). It runs as a web app, desktop app, or both.

What caught my eye: its plugin system. The default Kubernetes dashboard gives you a fixed view. Headlamp lets developers extend it with custom plugins. The plugin API uses React and TypeScript with a simple registration model — scaffold a plugin, write a component, register it. Simple enough that building custom dashboard views with an AI coding agent looks practical.

If you want a Kubernetes UI beyond the basics without paying for Lens, Headlamp deserves a look.

## prek

[prek](https://github.com/j178/prek) is a drop-in replacement for pre-commit, rewritten in Rust. Single binary, no Python dependency, fully compatible with existing .pre-commit-config.yaml files.

Faster, lighter, and no Python required just to run git hooks. CPython, Apache Airflow, and FastAPI already use it. I plan to try it on my own repos.

## Links

- [Headlamp](https://headlamp.dev/)
- [prek on GitHub](https://github.com/j178/prek)
- https://eventyay.com/e/88882f3e
