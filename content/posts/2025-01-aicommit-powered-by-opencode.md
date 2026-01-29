+++
title = "aicommit Powered by opencode"
date = "2025-01-29T14:00:00+07:00"
draft = false
tags = ["cli", "llm", "ai", "git"]
description = ""
+++

I really like the lazy `git add --all && aicommit && git push` one-liner when updating documentation or working on fun projects.

I used https://github.com/coder/aicommit before, but it requires pay-per-token API plans.
Since I already have GitHub Copilot and ChatGPT Plus subscriptions, I re-implemented `aicommit` to be powered by opencode (https://opencode.ai/) - now I can use models from those plans :)

https://github.com/jakshi/aicommit

Opencode seems to be a convenient way to integrate with scripts and leverage those $10-20/month subscriptions.

I should use it in more of my scripts :)
