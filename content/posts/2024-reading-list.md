+++
title = "What I Read in 2024"
date = "2026-02-20T10:00:00+07:00"
draft = false
tags = ["reading", "kubernetes", "containers", "ai", "aws", "sre"]
description = ""
+++

Continuing to reflect on articles that I read in recent years. Here is year 2024.

Kubernetes deep dives dominated (13 articles, especially the resource limits series and iximiuz container series). GitHub Copilot/AI continued growing (7 articles). New interests: team dynamics and management models (Belbin, Tuckman, Lencioni), and Python tooling with uv and pyproject.toml. Total: 54 articles.

## Kubernetes / Containers

1. [How K8s Eviction Works: Resource Management Gone Wrong](https://thenewstack.io/how-k8s-eviction-works-resource-management-gone-wrong/)
2. [How Kubernetes Memory Requests and Limits Actually Work](https://thenewstack.io/how-kubernetes-memory-requests-and-limits-actually-work/)
3. [How K8s CPU Requests and Limits Actually Work — Chapter 2](https://thenewstack.io/how-k8s-cpu-requests-and-limits-actually-work-chapter-2/)
4. [How Kubernetes Requests and Limits Really Work](https://thenewstack.io/how-kubernetes-requests-and-limits-really-work/)
5. [For the Love of God, Stop Using CPU Limits on Kubernetes](https://home.robusta.dev/blog/stop-using-cpu-limits?nocache=234)
6. [Computer Networking Fundamentals](https://iximiuz.com/en/posts/computer-networking-101/)
7. [How Container Networking Works: a Docker Bridge Network From Scratch](https://labs.iximiuz.com/tutorials/container-networking-from-scratch)
8. [Docker Containers vs. Kubernetes Pods - Taking a Deeper Look](https://labs.iximiuz.com/tutorials/containers-vs-pods)
9. [Containers 101: attach vs. exec - what's the difference?](https://iximiuz.com/en/tags/?tag=container-runtime-shim)
10. [Journey From Containerization To Orchestration And Beyond](https://iximiuz.com/en/posts/journey-from-containerization-to-orchestration-and-beyond/)
11. [Implementing Container Runtime Shim: runc](https://iximiuz.com/en/posts/implementing-container-runtime-shim/)
12. [Advantages of storing configuration in container registries rather than git](https://itnext.io/advantages-of-storing-configuration-in-container-registries-rather-than-git-b4266dc0c79f)
13. [Deploy Consul cluster peering locally with Minikube](https://www.hashicorp.com/blog/deploy-consul-cluster-peering-locally-with-minikube)

## SRE / Observability / Architecture

14. [The ROAD to SRE](https://medium.com/@bruce_25864/the-road-to-sre-ad4c73df78b8)
15. [Rethinking Observability](https://thenewstack.io/rethinking-observability/)
16. [OpenTelemetry parameter that might ruin your flexibility](https://sodkiewiczm.medium.com/opentelemetry-parameter-that-might-ruin-your-flexibility-edf3aa0d290a)
17. [Raft - Understandable Distributed Consensus](http://thesecretlivesofdata.com/raft/)
18. [Temporal - the iPhone of System Design](https://www.swyx.io/why-temporal)
19. [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
20. [AI Flame Graphs](https://www.brendangregg.com/blog//2024-10-29/ai-flame-graphs.html)
21. [Tog's paradox](https://www.votito.com/methods/togs-paradox/)

## AI / LLM / Copilot

22. [Getting started with GitHub Copilot](https://www.thoughtworks.com/insights/blog/generative-ai/getting-started-with-github-copilot)
23. [4 ways GitHub engineers use GitHub Copilot](https://github.blog/2024-04-09-4-ways-github-engineers-use-github-copilot/)
24. [10 unexpected ways to use GitHub Copilot](https://github.blog/2024-01-22-10-unexpected-ways-to-use-github-copilot/)
25. [Using GitHub Copilot in your IDE: Tips, tricks, and best practices](https://github.blog/2024-03-25-how-to-use-github-copilot-in-your-ide-tips-tricks-and-best-practices/)
26. [Hard and soft skills for developers coding in the age of AI](https://github.blog/2024-03-07-hard-and-soft-skills-for-developers-coding-in-the-age-of-ai/)
27. [Text-to-image AI models can be tricked into generating disturbing images](https://www.technologyreview.com/2023/11/17/1083593/text-to-image-ai-models-can-be-tricked-into-generating-disturbing-images/)
28. [Smarter Summaries w/ Finetuning GPT-3.5 and Chain of Density](https://jxnl.github.io/instructor/blog/2023/11/05/chain-of-density/)

## AWS / Cloud

29. [AWS's Egregious Egress](https://blog.cloudflare.com/aws-egregious-egress/)
30. [The AWS Service I Hate the Most](https://www.lastweekinaws.com/blog/the-aws-service-i-hate-the-most/)
31. [Leveraging Amazon S3 with Athena for Cost Effective Log Management](https://autify.com/blog/optimizing-cloud-application-log-management/)
32. [Using API Gateway for Authorization and Authentication](https://medium.com/expedia-group-tech/using-api-gateway-for-authorization-and-authentication-894a403d8614)

## Python / Tooling

33. [Writing your pyproject.toml](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/)
34. [uv: Unified Python packaging](https://astral.sh/blog/uv-unified-python-packaging)
35. [Developer Hacks — Modern Command Line Tools and Advanced Git Commands](https://medium.com/otto-group-data-works/developer-hacks-modern-command-line-tools-and-advanced-git-commands-e3724dab00a1)
36. [Git mistakes from Julia Evans](https://gist.github.com/jvns/f7d2db163298423751a9d1a823d7c7c1)
37. [What is Vim?](https://blog.jonas.foo/whats_vim.html)
38. [Biome isn't about biometrics, but suggestions](https://eclecticlight.co/2022/06/27/biome-isnt-about-biometrics-but-suggestions/)

## Software Engineering / Practices

39. [CUPID—for joyful coding](https://dannorth.net/cupid-for-joyful-coding/)
40. [An illustrated guide to the Advanced Encryption Standard (AES)](https://www.thoughtworks.com/insights/blog/privacy/illustrated-guide-advanced-encryption-standard)
41. [The Unintended Consequences of Open Sourcing Software](https://www.builder.io/blog/oss-consequences)
42. [Why your team doesn't need to use pull requests](https://infrastructure-as-code.com/posts/pull-requests.html)
43. [An Introduction to the F5 Experience](https://beerandserversdontmix.com/2024/08/15/an-introduction-to-the-f5-experience/)
44. [Bjarne Stroustrup's Plan for Bringing Safety to C++](https://thenewstack.io/bjarne-stroustrups-plan-for-bringing-safety-to-c/)
45. [Learn Dynamic Programming: A Beginner's Guide to the Coin Change Problem](https://betterprogramming.pub/learn-dynamic-programming-the-coin-change-problem-22a104478f50)
46. [Slime Mold (complexity growth in tech organizations)](https://komoroske.com/slime-mold/)

## Management / Career / Soft Skills

47. [Dear CTO: it's not 2015 anymore](https://blog.godfreyai.com/p/dear-cto-its-not-2015-anymore)
48. [The Red Beads Experiment](https://medium.com/make-work-better/w-edwards-demings-red-beads-experiment-dea18bfc2aba)
49. [Q&A: Expert advice on getting started in platform engineering](https://www.linkedin.com/pulse/qa-expert-advice-getting-started-platform-engineering-github-8nhoc/)
50. [Balancing Engineering Cultures: Debate Everything vs. Just Tell Me What To Build](https://www.fishmanafnewsletter.com/p/balancing-engineering-cultures-debate-vs-do)
51. [Lencioni's Five Dysfunctions of a Team](https://www.mindtools.com/a6ooqev/lencionis-five-dysfunctions-of-a-team)
52. [The Nine Belbin Team Roles](https://www.belbin.com/about/belbin-team-roles)
53. [Tuckman's Stages of Group Development](https://www.wcupa.edu/coral/tuckmanStagesGroupDelvelopment.aspx)
54. [5 tips to supercharge your developer career in 2024](https://github.blog/2024-05-01-5-tips-to-supercharge-your-developer-career-in-2024/)
