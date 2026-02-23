+++
title = "ThaiPy Meetup - DuckDB Talk"
date = "2026-02-23T10:00:00+07:00"
draft = false
tags = ["python", "duckdb", "meetup", "bangkok"]
description = ""
+++

Last Thursday I attended [ThaiPy](https://www.meetup.com/thaipy-bangkok-python-meetup/) - a monthly Python meetup in Bangkok. There was an interesting talk about DuckDB usage in Python.

I knew that DuckDB is superglue of data wrangling, but I didn't know that it's that powerful.

DuckDB can attach to various databases directly - for example Postgres:

```sql
ATTACH '' AS postgres_db (TYPE postgres);
SELECT * FROM postgres_db.tbl;
```

And save data to Parquet from any source - not just Postgres:

```sql
COPY postgres_db.tbl TO 'data.parquet';
COPY postgres_db.tbl FROM 'data.parquet';
```

In your code you can transparently switch between Pandas DataFrames and DuckDB, thanks to Apache Arrow:

```python
pandas_df = pd.DataFrame({"a": [42]})
duckdb.sql("SELECT * FROM pandas_df")
```

Actually you can represent your DuckDB results as almost any popular data crunching library in Python - Pandas, Polars, Arrow, NumPy:

```python
duckdb.sql("SELECT 42").fetchall()     # Python objects
duckdb.sql("SELECT 42").df()           # Pandas DataFrame
duckdb.sql("SELECT 42").pl()           # Polars DataFrame
duckdb.sql("SELECT 42").arrow()        # Arrow Table
duckdb.sql("SELECT 42").fetchnumpy()   # NumPy Arrays
```

![DuckDB Postgres integration](/img/thaipy-duckdb-postgres.jpg)
![DuckDB Pandas query](/img/thaipy-duckdb-pandas.jpg)
![DuckDB output formats](/img/thaipy-duckdb-arrow.jpg)
