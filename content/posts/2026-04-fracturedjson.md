+++
title = "FracturedJson - Human-Readable JSON Formatting"
date = "2026-04-09T10:00:00+07:00"
draft = false
tags = ["cli", "tools", "json"]
description = ""
+++

[FracturedJson](https://github.com/j-brooke/FracturedJson) is a JSON formatter that aligns similar structures like table columns, keeps simple arrays on one line, and collapses short objects.

```bash
brew install fracturedjson
```

The binary is called `fracjson`. Pipe any JSON through it:

```bash
echo '{"users":[{"name":"Alice","age":30,"roles":["admin","editor"],"active":true},{"name":"Bob","age":25,"roles":["viewer"],"active":false},{"name":"Charlie","age":35,"roles":["admin","viewer","editor"],"active":true}],"settings":{"theme":"dark","notifications":{"email":true,"sms":false,"push":true},"limits":[100,200,300,400,500]}}' | fracjson
```

```json
{
    "users"   : [
        { "name": "Alice",   "age": 30, "roles": ["admin",  "editor"          ], "active": true  },
        { "name": "Bob",     "age": 25, "roles": ["viewer"                    ], "active": false },
        { "name": "Charlie", "age": 35, "roles": ["admin",  "viewer", "editor"], "active": true  }
    ],
    "settings": {
        "theme"        : "dark",
        "notifications": {"email": true, "sms": false, "push": true},
        "limits"       : [100, 200, 300, 400, 500]
    }
}
```

The `users` array reads like a table. The `settings` block stays compact because each value fits on a single line. Standard formatters would spread this across 30+ lines with no visual structure.

https://github.com/j-brooke/FracturedJson
