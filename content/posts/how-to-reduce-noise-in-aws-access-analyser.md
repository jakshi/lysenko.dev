+++
date = "2023-05-18T14:40:00+07:00"
description = ""
draft = false
tags = ["aws", "security", "automation", "false-positive"]
title = "Insights on how to reduce noise in AWS Access Analyser"
topics = []

+++

# Review

Recently I read an interesting article:

https://aws.amazon.com/blogs/security/how-to-prioritize-iam-access-analyzer-findings/

Well, I don't expect it to be interesting for most of people.

But for people that are in charge of security reviews of company AWS accounts and review AWS Access Analyser - it makes life much simpler.

Basically it shows a way to mute repeated false postitives. For example when you use SSO all new SSO users will be shown in AWS Access Analyser - that probably not a good thing. Especially if you have a lot of those.

Then you can just go to `Archive rules` - and auto archive SSO users :)

More details are in the article.

<!--more-->

