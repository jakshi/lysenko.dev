+++
title = "FOSS Asia 2026 - SQL Expressions in Grafana"
date = "2026-03-19T10:00:00+07:00"
draft = false
tags = ["conference", "grafana", "sql", "monitoring", "foss-asia-2026"]
description = ""
+++

At [FOSS Asia 2026](https://eventyay.com/e/88882f3e) (Mar 8-10, Bangkok), note 5:

There was a talk about SQL Expressions — a new feature in Grafana 12 that lets you transform and combine query results using SQL syntax.

## The problem

Grafana has always had two ways to transform query data, and the distinction is confusing:

- **Server-side Expressions** — run by Grafana backend, simple math (`is_nan()`, `+`, `max()`, `/`), can be used in alerting rules and visualizations
- **Transformations** — run in the browser, support complex operations like joins and field selection, but can only be used for visualizations (no alerting)

So if you needed anything beyond simple math in an alert — you were stuck.

## SQL Expressions

SQL Expressions bridge this gap. They run server-side (like expressions) but support SQL syntax (like transformations) — including `SELECT`, `WHERE`, `JOIN`, `GROUP BY`, and string/boolean operations.

![SQL Expressions in Grafana 12 at FOSS Asia 2026](/img/foss-asia-2026-grafana-sql-expressions.jpg)

Key points:
- Use MySQL-like syntax (powered by [go-mysql-server](https://github.com/dolthub/go-mysql-server) from Dolthub)
- Can query results from any data source — Prometheus, Loki, Elasticsearch, PostgreSQL, etc. — as if they were tables in the same database
- Work with string and boolean fields (regular expressions only work on numeric fields)
- Can be used in **alerting rules** — this is the big one
- Autocomplete for both syntax and column names

## Cross-source joins

The most interesting part — you can join data from completely different sources. Prometheus metrics + MySQL tables + Google Sheets in one query. No ETL pipeline, no data warehouse, just SQL.

## Links

- [SQL Expressions documentation](https://grafana.com/docs/grafana/latest/visualizations/panels-visualizations/query-transform-data/sql-expressions/)
- [SQL Expressions blog post](https://grafana.com/blog/sql-expressions-in-grafana-combine-and-manipulate-data-from-multiple-sources/)
