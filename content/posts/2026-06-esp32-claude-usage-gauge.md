+++
date = "2026-06-29T10:00:00+07:00"
description = ""
draft = false
tags = ["hardware", "esp32", "claude-code", "ai", "diy"]
title = "I turned a tiny AMOLED board into a Claude Code usage gauge"
+++

I bought a [Waveshare ESP32-S3-Touch-AMOLED-1.8](https://www.waveshare.com/esp32-s3-touch-amoled-1.8.htm) — a thumb-sized dev board with a bright 1.8" AMOLED screen — and turned it into a desk gauge for my Claude Code usage. It sits next to my CO2 monitor and shows how much of my current and weekly limits I've burned. Building it was the addictive part — programming a little screen you can hold in your hand is a deep rabbit hole.

<!--more-->

![ESP32-S3 AMOLED board showing Claude Code current and weekly usage](/img/esp32-claude-usage.jpg)

## The board

Tiny but serious: an ESP32-S3 (dual-core LX7 at 240 MHz, 8 MB PSRAM, 16 MB flash), a 368×448 AMOLED panel driven over QSPI by an SH8601 controller, a capacitive touch layer, plus WiFi and Bluetooth 5 — all in something that fits in a matchbox.

## The stack — a pile of new words

I built the firmware with [PlatformIO](https://platformio.org/), a build system and toolchain manager for embedded boards that lives inside VS Code, and drew the UI with [LVGL](https://lvgl.io/), the Light and Versatile Graphics Library. LVGL hands you widgets, animations, and those rounded progress bars without hand-rolling a single pixel. The whole "Usage" screen — two gauges, reset countdowns, a battery icon, a blinking *Puttering…* status — is LVGL.

## Where the numbers come from

The board never talks to Anthropic. A small daemon on my Mac pings Haiku once a minute — the cheapest call I can make — reads the usage numbers off the response, and pushes them to the board over Bluetooth LE. The screen renders whatever it last received.

I started from [Clawdmeter](https://github.com/HermannBjorgvin/Clawdmeter) and diverged: faster wake, a sturdier daemon, and my own button scheme. One tap on the power switch cycles screens, a three-second hold pairs Bluetooth, a six-second hold powers it off. The second button is my favorite — it auto-approves Claude Code's permission prompts, so I can green-light an agent from across the desk.

My code is still messy, so I'll publish the repo once it's tidy. Until then: a small screen showing one number is a shockingly effective way to make yourself watch that number.
