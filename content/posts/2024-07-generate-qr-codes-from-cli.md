+++
title = "Generate QR Codes with URL From CLI"
date = "2024-07-13T19:19:38+07:00"
draft = false
tags = ["cli", "qr-code", "url"]
description = ""
+++

Why? It can be useful to have a QR code for a URL, opportunities are endless. For example, you can print it on your business card, or use it for sharing information about a user group.

# Generate QR code

```bash
brew install qrtool
qrtool encode "https://lysenko.dev" -t ansi-true-color # Generate QR code in terminal
qrtool encode "https://lysenko.dev" > qr.png # Generate QR code in PNG format
```

URL can be scanned by any mobile device with a camera - and it will open the URL in a browser.

# References

* [qrtool](https://sorairolake.github.io/qrtool/book/index.html)

<!--more-->
