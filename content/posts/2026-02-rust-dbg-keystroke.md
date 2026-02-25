+++
title = "Wrap and Unwrap Rust dbg!() with a Single Keystroke"
date = "2026-02-25T10:00:00+07:00"
draft = false
tags = ["rust", "zed", "vim", "debugging"]
description = ""
+++

When I work on Rust code, I sometimes wrap expressions with `dbg!()` to inspect values. So I configured a single keystroke (`\d`) to wrap selected expression. Essentially it cuts the selection, puts it in `dbg!()` and then pastes selection inside `dbg!()`. And vice versa.

I use Zed with vim mode, in Zed keymap config it looks like this:

```json
{
  "context": "vim_mode == visual",
  "bindings": {
    "\\ d": ["workspace::SendKeystrokes", "\" a c dbg!( ctrl-r a ) escape"],
  },
},
{
  "context": "vim_mode == normal",
  "bindings": {
    "\\ d": ["workspace::SendKeystrokes", "v a a \" a y g v [ x [ x \" a p"],
  },
},
```

The same idea should work in any editor with vim keybindings.

Found this trick in [Zed's Hidden Gems blog post](https://zed.dev/blog/hidden-gems-team-edition-part-1).
