+++
title = "FOSS Asia 2026 - PostgreSQL as a Message Queue"
date = "2026-03-11T10:00:00+07:00"
draft = false
tags = ["conference", "postgresql", "queue", "foss-asia-2026"]
description = ""
+++

At [FOSS Asia 2026](https://eventyay.com/e/88882f3e) (Mar 8-10, Bangkok), note 1:

It's been said many times already — at small to medium scale, PostgreSQL can cover a surprising number of use cases: relational database, document store (JSONB), cache, full-text search, vector search, and yes — a message queue.

There was a great talk about using PostgreSQL as a queue, and the approach is simpler than you'd think.

## The idea

Instead of adding RabbitMQ, Redis, or SQS to your stack — just use a table:

![Queue table design at FOSS Asia 2026](/img/foss-asia-2026-pg-queue-table.jpg)

The key columns: `name`, `key`, `status`, `payload` (JSONB), `retry_count`, and timestamps. The table is partitioned by `enqueue_dt` for performance.

## The secret sauce: `SELECT ... FOR UPDATE SKIP LOCKED`

This is what makes PostgreSQL work as a queue. A consumer grabs pending messages and locks them in a single transaction — other consumers skip already-locked rows instead of waiting. No double processing, no external locking mechanism.

The consumer workflow:
1. `SELECT ... FOR UPDATE SKIP LOCKED` — grab and lock pending messages
2. Process each message — call APIs, run business logic
3. `UPDATE` status (success/failure)
4. `COMMIT`

## Partitioning for scale

Partitioning by date (`PARTITION BY RANGE (enqueue_dt)`) gives you:
- Smaller indexes = faster queries
- Drop old partitions instantly (vs slow `DELETE`)
- `VACUUM` becomes trivial because it only touches a small slice of data

## When to reach for something bigger

If you don't want a DIY solution and need visibility timeouts, dead letter queues, message archiving, and a proper API around it — check out [PGMQ](https://github.com/pgmq/pgmq). It's a PostgreSQL extension that wraps all of this into a clean interface, similar to AWS SQS:

```sql
SELECT pgmq.create('my_queue');
SELECT pgmq.send('my_queue', '{"event": "order_created"}'::jsonb);
SELECT * FROM pgmq.read('my_queue', 30, 1);  -- 30s visibility timeout
```

PGMQ adds visibility timeouts, dead letter queues, message archiving, and client libraries for most languages.

## Links

- https://github.com/pgmq/pgmq
- https://eventyay.com/e/88882f3e
