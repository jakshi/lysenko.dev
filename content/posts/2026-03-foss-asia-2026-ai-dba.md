+++
title = "FOSS Asia 2026 - AI DBA: The State of Self-Driving Databases"
date = "2026-03-24T10:00:00+07:00"
draft = false
tags = ["conference", "database", "ai", "percona", "foss-asia-2026"]
description = ""
+++

At [FOSS Asia 2026](https://eventyay.com/e/88882f3e) (Mar 8-10, Bangkok), note 8:

[Peter Zaitsev](https://linkedin.com/in/peterzaitsev/), founder of [Percona](https://www.percona.com/) and co-author of *High Performance MySQL*, tackled the self-driving database question head-on. Oracle coined "Autonomous Database" back in 2017. The AI wave revived the idea. Peter separated what works today from what remains hype.

## Self-Driving Database

![Self Driving Database — Oracle Autonomous Database parallel with self-driving cars](/img/foss-asia-2026-ai-dba-self-driving.jpg)

The analogy comes from cars: self-provision, self-tune, self-patch, self-secure, self-repair. Oracle promised to eliminate human DBAs from routine operations in 2017. Nine years later, the question stands: how far have we come?

## Levels of Automation

![Levels of Self Driving — from no automation to full automation](/img/foss-asia-2026-ai-dba-levels.jpg)

Peter mapped the autonomous driving scale (Level 0 through Level 5) onto databases. Most production systems sit at Level 1-2: driver assistance and partial automation. Auto-scaling, automated backups, query optimizers — these exist. Full autonomy, where a database manages itself end-to-end? Still distant.

## The Real Question: Opportunity Cost

![The question is not if Best Human DBA can do better than AI DBA](/img/foss-asia-2026-ai-dba-opportunity-cost.jpg)

This slide hit hardest. Peter reframed the entire debate:

> "The question is not if Best Human DBA can do better than AI DBA. But can resource you have available. And what is the opportunity cost."

Most teams lack a world-class DBA. They have an engineer who also handles the database. For that engineer, an AI DBA that reliably tunes configs, flags slow queries, and recommends scaling frees hours every week — hours better spent on work that demands human judgment.

## Where AI Delivers Today

![AI Performance Optimization — Configuration, Environment Scale, Schema and Storage, Queries, Application Architecture](/img/foss-asia-2026-ai-dba-optimization.jpg)

Peter identified five areas where AI-driven optimization already works:

- **Configuration** — tuning parameters to match workload patterns
- **Environment Scale** — right-sizing instances and storage
- **Schema and Storage** — recommending indexes and partitioning strategies
- **Queries** — spotting and rewriting slow queries
- **Application Architecture** — suggesting caching layers, read replicas, connection pooling

None of these require a breakthrough. Percona's monitoring stack, EverSQL, OtterTune, AWS Performance Insights, and Azure Database Advisor already handle parts of this work. AI makes them faster and more proactive.

## Tradeoffs Remain Human

AI can optimize for a metric. Choosing which metric to optimize for — that stays with us. Correct vs fast. Cheap vs reliable. Fast vs reliable. Simple vs performant. Each tradeoff encodes a business decision that requires context no model possesses.

## The Takeaway

Self-driving databases advance incrementally, not in leaps. Level 5 remains years away. But Level 2-3 automation works now and delivers real value — especially for teams without a dedicated DBA. The useful framing: AI handles the routine so engineers can focus on what matters.

## Links

- [Peter Zaitsev on LinkedIn](https://linkedin.com/in/peterzaitsev/)
- [Percona](https://www.percona.com/)
- [Session on eventyay](https://eventyay.com/e/88882f3e/session/10594)
- https://eventyay.com/e/88882f3e
