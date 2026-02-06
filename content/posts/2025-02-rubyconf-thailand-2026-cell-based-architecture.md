+++
title = "RubyConf Thailand 2026 - Cell-Based Architecture"
date = "2025-02-05T10:00:00+07:00"
draft = false
tags = ["ruby", "architecture", "conference", "reliability"]
description = ""
+++

Last weekend at [RubyConf Thailand 2026](https://rubyconfth.com/), note 2:

Watched a talk on cell-based architecture in Rails by Roonglit Chareonsupkul.

And I really like the idea of limiting blast radius. Not only for Rails, for any kind of stack.

A cell is a self-contained slice of your system - its own app instances, database, cache, queues. You replicate cells and route users/tenants to specific cells.

Also cells play well with canary deployments. Deploy new version to one cell first, verify, then roll out to others. If something breaks - bad code, bad migration, resource leak - only that cell's users are affected. Others keep running on their own isolated stack.

Without cells, canary helps with gradual rollout, but all users still share the same DB and infra. With cells, you get canary + hard isolation.

The bulkhead pattern from ships: one compartment floods, the rest stay dry.

![Bulkhead pattern - cell-based architecture](/img/cell-based-architecture-bulkhead-pattern.png)

## References

- [AWS Well-Architected: Cell-Based Architecture](https://docs.aws.amazon.com/wellarchitected/latest/reducing-scope-of-impact-with-cell-based-architecture/what-is-a-cell-based-architecture.html) - AWS guide on reducing scope of impact with cells
