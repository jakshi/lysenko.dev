+++
title = "DuckDB Skills - Query Any Data Format from Claude Code"
date = "2026-04-10T10:00:00+07:00"
draft = false
tags = ["ai", "cli", "tools", "claude", "data"]
description = ""
+++

DuckDB reads CSV, JSON, Parquet, Avro, Excel, spatial formats, SQLite, and Jupyter notebooks. It connects to PostgreSQL, MySQL, and SQLite databases. It fetches files from S3, GCS, Azure, and HTTPS URLs. [duckdb-skills](https://github.com/duckdb/duckdb-skills) opens all of these to Claude Code through a single plugin.

```
/plugin marketplace add duckdb/duckdb-skills
/plugin install duckdb-skills@duckdb-skills
```

The plugin provides six skills: `attach-db`, `query`, `read-file`, `duckdb-docs`, `read-memories`, and `install-duckdb`.

`read-file` detects the format, reads the schema, and previews the data:

```
/duckdb-skills:read-file data.parquet
```

`query` accepts plain English or raw SQL:

```
/duckdb-skills:query Average stars and issues by language from projects.csv?
```

```
language,avg_stars,avg_issues,projects
TypeScript,12600,77,2
Python,10133,70,3
Rust,8767,22,3
Go,6550,38,2
```

Ad-hoc queries run in a sandbox — DuckDB limits file access to the referenced files, blocks external connections, and locks the configuration. Queries against an attached database run with full access.

`duckdb-docs` searches DuckDB documentation offline. `read-memories` recalls context from previous Claude Code sessions.

Every format DuckDB supports, every provider it connects to — available in Claude Code with one install.

https://github.com/duckdb/duckdb-skills
