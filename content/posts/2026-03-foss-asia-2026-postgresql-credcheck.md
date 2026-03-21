+++
title = "FOSS Asia 2026 - Password Policies in PostgreSQL with credcheck"
date = "2026-03-21T10:00:00+07:00"
draft = false
tags = ["conference", "postgresql", "security", "foss-asia-2026"]
description = ""
+++

At [FOSS Asia 2026](https://eventyay.com/e/88882f3e) (Mar 8-10, Bangkok), note 6:

There was a talk on authentication and security enforcement in PostgreSQL. PostgreSQL relies on extensions for non-essential features, and credential policy enforcement is one of those gaps in the extension ecosystem that [credcheck](https://github.com/HexaCluster/credcheck) fills nicely.

It enforces password and username rules during user creation and password changes.

## What it can enforce

**Password rules:**
- Minimum length, required digits, uppercase, lowercase, special characters
- Maximum character repetition
- Password cannot contain username
- Password reuse prevention (history-based)
- Password expiration with configurable valid period

**Username rules** — this was surprising, the extension validates usernames too:

![credcheck password complexity rules at FOSS Asia 2026](/img/foss-asia-2026-pg-credcheck.jpg)

Minimum length, required character types, must/must-not contain specific characters — all configurable.

## Authentication failure protection

credcheck can also ban users after N failed login attempts:

```sql
SET credcheck.max_auth_failure = 3;
```

After 3 failures, the user is locked out even with the correct password. Admins can unban with `SELECT pg_banned_role_reset('username')`.

## Setup

Add to `shared_preload_libraries` in `postgresql.conf` and restart:

```
shared_preload_libraries = 'credcheck'
```

Then configure via GUC parameters:

```sql
SET credcheck.password_min_length = 8;
SET credcheck.password_min_upper = 1;
SET credcheck.password_min_digit = 1;
SET credcheck.password_min_special = 1;
SET credcheck.password_reuse_history = 3;
SET credcheck.password_valid_until = 60;  -- days
```

## Logging and auditing

The talk also covered PostgreSQL security basics worth mentioning:
- Enable `log_connection` / `log_disconnection` in `postgresql.conf`
- Use `%u, %d, %h, %a` in `log_line_prefix` (user, database, host, application)
- Use [pg_audit](https://github.com/pgaudit/pgaudit) extension for detailed audit logging
- Send logs to a remote host with rsyslog

## Links

- https://github.com/HexaCluster/credcheck
- https://eventyay.com/e/88882f3e
