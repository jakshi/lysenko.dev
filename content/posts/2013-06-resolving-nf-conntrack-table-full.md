+++
date = "2013-06-16T13:55:00+07:00"
description = ""
draft = false
tags = ["linux", "networking", "sysctl", "kernel"]
title = "Resolving 'nf_conntrack: table full, dropping packet' on Linux"
aliases = ["/post/resolving-nf-conntrack-table-full/"]
+++

If you see this in `dmesg` on a busy Linux server:

```
nf_conntrack: table full, dropping packet
```

it means the kernel's connection-tracking table (used by Netfilter / iptables) has hit its size limit and is dropping new connections. Until you fix it, packets get silently dropped.

<!--more-->

## Check the current state

```bash
# Current entries vs limit
cat /proc/sys/net/netfilter/nf_conntrack_count
cat /proc/sys/net/netfilter/nf_conntrack_max

# Hash bucket size (rule of thumb: nf_conntrack_max / 4 or /8)
cat /sys/module/nf_conntrack/parameters/hashsize
```

If `count` is at or near `max`, that's your problem.

## Bump the limits

Pick a new ceiling that fits your workload and available RAM (each entry is ~300 bytes, so 1M entries ≈ 300 MB).

```bash
# Apply at runtime
sudo sysctl -w net.netfilter.nf_conntrack_max=1048576
echo 262144 | sudo tee /sys/module/nf_conntrack/parameters/hashsize
```

Make it survive reboots in `/etc/sysctl.d/conntrack.conf`:

```
net.netfilter.nf_conntrack_max = 1048576
net.netfilter.nf_conntrack_buckets = 262144
```

## Reduce timeout knobs

If the table fills up because connections linger, reduce the per-state timeouts:

```
net.netfilter.nf_conntrack_tcp_timeout_established = 86400
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 30
net.netfilter.nf_conntrack_generic_timeout = 120
```

Defaults often keep `time_wait` at 120s and `established` at 5 days, which is excessive on busy proxies.

## Better: do you need conntrack at all?

If the server is a load balancer, NAT gateway, or firewall — yes, you need it. If it's a plain web server with no NAT and no stateful iptables rules, you can disable conntrack on specific traffic with the `NOTRACK` target, or unload `nf_conntrack` entirely.

## References

- [kernel.org: nf_conntrack-sysctl.txt](https://www.kernel.org/doc/Documentation/networking/nf_conntrack-sysctl.txt)
