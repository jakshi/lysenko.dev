+++
date = "2023-05-06T17:37:00+07:00"
description = ""
draft = false
tags = ["vim", "neovim", "spacevim", "how-to"]
title = "How to add showcmd to spacevim"

+++

# How to display commands that you type in Normal mode in statusbar
As a novice in vim I would like to visually see which command I'm typing when I use VIM.  
It appears not so straightforward in SpaceVIM as it already have pretty much magic around configuration.  
When I wrote this documentation I used spacevim version `2.1.0` and neovim version `0.9`.

<!--more-->

## Simple and ugly way

to `~/.SpaceVim.d/init.toml` add:

```
[options]

...

bootstrap_after = "myspacevim#after"
```

to `~/.SpaceVim.d/autoload/myspacevim.vim` add:

```
function! myspacevim#after() abort
set showcmd
endfunction
```

Now you will have 1 extra line where you can see commands that you type.  
Unfortunately commands will be displayed in the right.  
It can be quite inconvenient for some of the users.

## Complex and more nice way
So I started to think how can I integrate those into SpaceVIM statusline.  
Spacevim use heavily tuned vim-airline.

So after some reading, experiments and thoughtful (who I'm trying to fool) conversation with ChatGPT I got the folling code:

to `~/.SpaceVim.d/init.toml` add:

```
[options]

...

    statusline_left = [
        'winnr',
        'filename',
        'major mode',
        'minor mode lighters',
        'version control info',
        'search status',
        'showcmd'
    ]

    bootstrap_after = "myspacevim#after"
```

to `~/.SpaceVim.d/autoload/myspacevim.vim` add:

```
function! myspacevim#after() abort
set showcmd
set showcmdloc=statusline

function! s:showcmd_section() abort
  return ' %S '
endfunction
call SpaceVim#layers#core#statusline#register_sections('showcmd', function('s:showcmd_section'))
endfunction
```

I should note that according to NeoVIM changelog at: https://github.com/neovim/neovim/blob/040f1459849ab05b04f6bb1e77b3def16b4c2f2b/runtime/doc/news.txt that `%S` is supported from version `0.9` - so if you use neovim - be sure to upgrade to at least version `0.9`.

## References

* NeoVim changelog: https://github.com/neovim/neovim/blob/040f1459849ab05b04f6bb1e77b3def16b4c2f2b/runtime/doc/news.txt
* NeoVim documentation: Options: https://neovim.io/doc/user/options.html
* SpaceVim docs: core#statusline layer: https://spacevim.org/layers/core/statusline/
* SpaceVim docs: statusline: https://spacevim.org/documentation/#statusline
* SpaceVim docs: bootstrap functions: https://spacevim.org/documentation/#bootstrap-functions
* statusline.vim: https://github.com/SpaceVim/SpaceVim/blob/master/autoload/SpaceVim/layers/core/statusline.vim
* vim-airline: https://github.com/vim-airline/vim-airline
* vim-airline FAQ: https://github.com/vim-airline/vim-airline/wiki/FAQ
