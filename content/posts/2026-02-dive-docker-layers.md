+++
title = "Dive - Explore Docker Image Layers"
date = "2026-02-27T10:00:00+07:00"
draft = false
tags = ["docker", "cli", "tools"]
description = ""
+++

[Dive](https://github.com/wagoodman/dive) shows Docker image content layer by layer - useful to understand how an image was built and what's inside.

It also shows image efficiency score, potentially wasted space, and size of each layer - handy for Docker image optimization.

```bash
brew install dive
dive <image>  # e.g. dive rabbitmq:4.2.3-management
```

![Dive screenshot](/img/dive-screenshot.png)

https://github.com/wagoodman/dive
