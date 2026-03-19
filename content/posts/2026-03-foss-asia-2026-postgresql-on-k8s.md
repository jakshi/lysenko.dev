+++
title = "FOSS Asia 2026 - PostgreSQL on Kubernetes"
date = "2026-03-12T10:00:00+07:00"
draft = false
tags = ["conference", "postgresql", "kubernetes", "k8s", "foss-asia-2026"]
description = ""
+++

At [FOSS Asia 2026](https://eventyay.com/e/88882f3e) (Mar 8-10, Bangkok), note 4:

Running a stateful service like a database on Kubernetes has historically been a topic of debate. However, the ecosystem has matured significantly. The main point of the database-related talks this year was clear: **making PostgreSQL setups in Kubernetes easier to maintain, declarative, and highly available.**

I saw two particularly interesting pieces of software for running databases on K8s:

## CloudNativePG

There was a great talk: *"Run PostgreSQL on Kubernetes in Production with CloudNativePG"*.

![CloudNativePG presentation at FOSS Asia 2026](/img/foss-asia-2026-cloudnativepg.jpg)

[CloudNativePG](https://cloudnative-pg.io/) is an open-source Kubernetes operator that covers the full lifecycle of a highly available PostgreSQL database cluster. It uses a primary/standby architecture with native streaming replication.

The beauty of CloudNativePG is that it brings autopilot capabilities to your database. It handles automated failover, data persistence, and TLS certificates out of the box. Because it's completely declarative and relies on the Kubernetes API server to maintain the state, you don't need external failover management tools.

## OpenEverest (from Solanica)

Another interesting project I stumbled upon at the **Solanica** stand in the exhibition area was **OpenEverest**.

![OpenEverest platform at FOSS Asia 2026](/img/foss-asia-2026-openeverest.jpg)

[OpenEverest](https://github.com/openeverest/openeverest) is an open-source platform from Solanica for automated database provisioning and management. While CloudNativePG is specifically focused on PostgreSQL, OpenEverest takes a broader DBaaS (Database-as-a-Service) approach. It supports multiple database technologies (including PostgreSQL) and can be hosted on any Kubernetes infrastructure—whether in the cloud or on-premises.

If you are running a larger internal platform and want to offer a self-service DB portal to your developers, tools like OpenEverest aim to simplify that exact problem.

## The Takeaway

Running PostgreSQL on Kubernetes is no longer a fringe idea. Between specialized operators like CloudNativePG and broader DBaaS platforms like OpenEverest, the tooling now exists to run production-grade, highly available database clusters with significantly reduced maintenance overhead.
