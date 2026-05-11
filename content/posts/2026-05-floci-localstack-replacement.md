+++
date = "2026-05-11T11:00:00+07:00"
description = ""
draft = false
tags = ["aws", "localstack", "docker", "just"]
title = "Floci: a free, faster LocalStack replacement"
+++

Most local AWS development goes through LocalStack. The free tier covers the basics; Pro covers the rest behind a paid token. For a long time that was the only serious option for "run AWS on my laptop."

[Floci](https://github.com/floci-io/floci) is the first alternative I've found worth using. Open-source (MIT), 45 services, drop-in LocalStack Community replacement. The pitch from the project: "no auth token, no restrictions, ever."

<!--more-->

It's also fast. Built on Quarkus Native, so the binary is compiled, not JVM-warm. Project benchmarks claim 24ms cold start vs LocalStack's ~3s, and 13 MiB idle vs ~140 MiB. I haven't benchmarked it myself, but the difference is obvious in use.

## Install

One container. Mount the Docker socket if you want Floci to spin up Lambda/ECS sub-containers. Default port `4566` — same as LocalStack, so existing SDK/CLI config keeps working.

`docker-compose.yml`:

```yaml
services:
  floci:
    image: floci/floci:latest
    container_name: floci
    restart: unless-stopped
    ports:
      - "4566:4566"
    user: root
    environment:
      FLOCI_STORAGE_MODE: hybrid
      FLOCI_DEFAULT_REGION: us-east-1
      FLOCI_DEFAULT_ACCOUNT_ID: "000000000000"
      QUARKUS_LOG_LEVEL: INFO
    volumes:
      - ./data:/app/data
      - /var/run/docker.sock:/var/run/docker.sock
    healthcheck:
      test: ["CMD", "curl", "-fsS", "http://localhost:4566/_localstack/health"]
      interval: 10s
      timeout: 3s
      retries: 5
      start_period: 10s
```

Note the health endpoint: `_localstack/health`. LocalStack-parity is on by default — existing tooling that pings LocalStack works unchanged.

My SDK/CLI env vars live globally in `~/.bash.d/aws.sh`:

```bash
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
```

Every shell already points at Floci — `aws s3 ls` Just Works the moment the container is up.

## Storage mode: pick hybrid

Floci has four storage modes. Worth knowing before you commit:

| Mode | Behavior | Use for |
|---|---|---|
| `memory` | Fastest. No restart survival. | CI, unit tests |
| `persistent` | Synchronous disk write on every change. | Anything that must not lose data |
| `hybrid` | In-memory reads, async flush to disk. | Local development |
| `wal` | Append-only write-ahead log with compaction. | High-write workloads |

`hybrid` is the right default for daily local work. Near-memory speed for reads, data survives container restart, no per-write fsync cost. The other modes are useful for specific scenarios — but for "I just want AWS locally," hybrid wins.

## My setup

I drive everything through a `justfile`. Single command to start, smoke test, tail logs, wipe state.

```make
set shell := ["bash", "-cu"]

default:
    @just --list

up:
    docker compose pull
    docker compose up -d
    @echo "Floci at http://localhost:4566"

down:
    docker compose down

restart: down up

logs service="floci":
    docker compose logs -f {{service}}

health:
    @curl -fsS http://localhost:4566/_localstack/health | { command -v jq >/dev/null && jq . || cat; }

shell:
    docker compose exec floci sh

wipe:
    docker compose down
    rm -rf data
    @echo "State wiped."
```

Day-to-day flow:

```bash
just up      # start
just health  # check it's ready
just logs    # tail when something looks off
just down    # stop
just wipe    # nuke state if needed
```

## The multi-account trick

Floci treats a 12-digit access key as the account ID — useful when testing cross-account behavior locally:

```bash
AWS_ACCESS_KEY_ID=111111111111 aws sqs create-queue --queue-name orders
AWS_ACCESS_KEY_ID=222222222222 aws sqs create-queue --queue-name orders
```

Two separate queues, two separate accounts, one container. Full details — per-account storage namespacing, default-account fallback, LocalStack-parity note — in the [multi-account docs](https://github.com/floci-io/floci/blob/main/docs/configuration/multi-account.md).

## Closing

Repo: https://github.com/floci-io/floci

If you've been on LocalStack Community and feeling the Pro nudge, this is a real alternative. Free, fast, actively developed, and your existing config almost certainly already works.
