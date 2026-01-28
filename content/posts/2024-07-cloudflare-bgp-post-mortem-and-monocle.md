+++
title = "Cloudflare 1.1.1.1 outage Post Mortem and Monocle"
date = "2024-07-06T18:23:02+07:00"
draft = false
tags = ["bgp", "post-mortem", "monocle", "cloudflare"]
description = "Cloudflare 1.1.1.1 outage post mortem and Monocle tool"

+++

Recently I read quite interesting 1.1.1.1 DNS outage post-mortem from Cloudflare: https://blog.cloudflare.com/cloudflare-1111-incident-on-june-27-2024  

It's really fascinating to read about BGP security and at the same time quite concerning that some Tier-1 ISP still doesn't have proper BGP security in place.  

When I read technical details of the post-mortem - I also found out about Monocle tool that allow to investigate BGP routing (issues): https://github.com/bgpkit/monocle  
Btw, Monocle is written in Rust :)

<!--more-->

