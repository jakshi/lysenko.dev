+++
title = "FOSS Asia 2026 - Why Cluster API Alone Isn't Enough"
date = "2026-03-23T10:00:00+07:00"
draft = false
tags = ["conference", "kubernetes", "k8s", "cluster-api", "platform-engineering", "foss-asia-2026"]
description = ""
+++

At [FOSS Asia 2026](https://eventyay.com/e/88882f3e) (Mar 8-10, Bangkok), note 7:

Cluster API has been around since 2018 and is increasingly the go-to approach for declarative Kubernetes cluster lifecycle management — though still in beta (v1beta1 → v1beta2). A Mirantis talk on CAPI's pain points and what the open-source ecosystem is building on top of it got me curious.

## The Reality Check

![Kubernetes Reality Check — the easy parts vs the hard parts](/img/foss-asia-2026-capi-reality-check.jpg)

Kubernetes makes the basics easy — container scheduling, service discovery, rolling updates, self-healing pods. But once you're managing 10-100+ clusters across AWS, Azure, on-prem, and edge, you hit a different class of problems: multi-cloud provisioning, fleet-wide upgrades, consistent governance, and cross-cluster observability.

## What Is Cluster API?

[Cluster API](https://cluster-api.sigs.k8s.io/) (CAPI) is an official Kubernetes sub-project under SIG Cluster Lifecycle. The core idea: **manage Kubernetes clusters the same way Kubernetes manages pods** — declaratively, through manifests and controllers.

You run a *management cluster* with CAPI controllers, and those controllers provision and manage *workload clusters* on any infrastructure with a CAPI provider (AWS, Azure, vSphere, bare metal, etc.). There's a `clusterctl` CLI to get started quickly — installing providers, generating manifests — but since CAPI is just Kubernetes CRDs, teams at scale typically manage it declaratively via GitOps (Flux, ArgoCD) or integrate it programmatically into their own tooling.

## CAPI: Promise and Pain

![ClusterAPI — Promise and Pain](/img/foss-asia-2026-capi-promise-pain.jpg)

The speaker framed the tension well. CAPI *promises* declarative cluster lifecycle, Kubernetes-native APIs, a provider-agnostic model, and the ability to manage clusters like pods.

But the *pain* is real: intricate YAML definitions, juggling bootstrap + control plane + infrastructure providers, no built-in add-on management, and a steep learning curve.

The quote on the slide nailed it:

> "CAPI gives you power — but at the cost of complexity."

## The Real-World Consequences

![Real-world consequences of CAPI alone](/img/foss-asia-2026-capi-consequences.jpg)

When teams use CAPI alone at scale, they run into inconsistent provisioning (bespoke configs per environment, no golden path), version drift and security risk, high operational overhead on day-2 ops, and no single pane of glass for observability.

The bottom line: *CAPI alone isn't enough. Teams need a platform engineering approach — composable templates, policy-driven add-ons, and built-in observability.*

## The Solution: k0rdent + Sveltos

The talk argued that assembling raw open-source tools yourself is complex, and pre-integrated platforms aim to reduce that burden. This is where two open-source projects come in.

### Sveltos

![Introducing Sveltos](/img/foss-asia-2026-sveltos-intro.jpg)

[Sveltos](https://github.com/projectsveltos) is an open-source Kubernetes add-on controller that addresses CAPI's "no built-in add-on management" gap. It deploys Helm charts, raw YAML, Kustomize, and more across your entire fleet — with dependency ordering, drift detection, and multi-tenancy support.

### k0rdent

![k0rdent architectural view](/img/foss-asia-2026-k0rdent-architecture.jpg)

[k0rdent](https://github.com/k0rdent/k0rdent) is an open-source platform by Mirantis (open-sourced Feb 2025) that bundles everything together into three components:

- **KCM** (Cluster Manager) — provisions and manages cluster lifecycle using CAPI
- **KSM** (State Manager) — wraps Sveltos under the hood for add-on and application lifecycle
- **KOF** (Observability Framework) — aggregates metrics, logs, and traces from all managed clusters

Sveltos isn't a separate tool you stitch together — it's integrated as the state management engine inside k0rdent. The result addresses exactly what the speaker identified as CAPI's shortcomings: add-on management, policy enforcement, and observability in one place.

## The Takeaway

If you're running a handful of clusters, CAPI with some scripts on top might be fine. But at scale — tens or hundreds of clusters across multiple environments — you need templated provisioning, policy-driven add-ons, and centralized observability. The open-source ecosystem is maturing to fill this gap, and k0rdent's approach of composing CAPI + Sveltos + observability into a coherent platform is a pragmatic path — all components are open source, no vendor lock-in.

## Links

- [Cluster API](https://cluster-api.sigs.k8s.io/)
- [k0rdent on GitHub](https://github.com/k0rdent/k0rdent)
- [Sveltos on GitHub](https://github.com/projectsveltos)
- [CNCF: Introducing k0rdent](https://www.cncf.io/blog/2025/02/24/introducing-k0rdent-design-deploy-and-manage-kubernetes-based-idps/)
- [CNCF: Untangling Kubernetes State Management — Sveltos & k0rdent](https://www.cncf.io/online-programs/cncf-on-demand-untangling-kubernetes-state-management-a-tryst-with-sveltos-k0rdent/)
- https://eventyay.com/e/88882f3e
