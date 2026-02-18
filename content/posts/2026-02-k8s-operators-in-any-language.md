+++
title = "You Can Write Kubernetes Operators in Almost Any Language"
date = "2026-02-18T10:00:00+07:00"
draft = false
tags = ["kubernetes", "operators", "rust", "python", "go"]
description = ""
+++

As strange as it sounds, you can write Kubernetes operators in almost any language. Most people write operators with [kubebuilder](https://book.kubebuilder.io/) in Go, but it's not the only option.

Here are some frameworks from the [official Kubernetes docs](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/):

- **Go**: [kubebuilder](https://book.kubebuilder.io/), [Operator Framework](https://operatorframework.io)
- **Python**: [Kopf](https://github.com/nolar/kopf), [Charmed Operator Framework](https://juju.is/)
- **Rust**: [kube-rs](https://kube.rs/)
- **Java**: [Java Operator SDK](https://github.com/operator-framework/java-operator-sdk)
- **.NET**: [KubeOps](https://dotnet.github.io/dotnet-operator-sdk/)
- **Shell**: [shell-operator](https://github.com/flant/shell-operator) :D

Yes, you can write a Kubernetes operator with shell scripts.

Has anybody actually tried writing a K8s operator in Rust? I'd love to hear about the experience.
