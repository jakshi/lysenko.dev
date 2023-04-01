+++
title = "Article review - The SPACE of Developer Productivity"
date = "2023-04-01T12:40:00+07:00"
draft = false
tags = ["productivity", "review", "article"]
topics = []
description = ""
summary = """
Great article about developers productivity:
[The SPACE of Developer Productivity](https://queue.acm.org/detail.cfm?id=3454124)
And my thoughts about it.
"""
+++

Great article about developers productivity:
[The SPACE of Developer Productivity](https://queue.acm.org/detail.cfm?id=3454124)
And my thoughts about it.

Most interesting insights for me:

* There's no universal developers productivity metric, it's multi-dimensional space.
* It's important for developers to get access to their productivity metrics to reflect on them.
* Joy and friendly environment is one of metrics that impact developers productivity, "don't be too serious" is literally improve productivity.
* Work to keep environment and culture healthy is often "invisible" and not measured (But it should be).
* Team productivity is more important measurement than individual performance.
  * I heard that some company stop measure individual performance altogether and concentrate on team performance measurement.
* SPACE - multidimensional framework for measuring productivity - Satisfaction, Performance, Activity, Efficiency
  * Code Reviews metrics can cover all five dimensions of SPACE framework.
  * When choose what to measure choose:
    * at least 3 metric from different dimensions
    * at least 1 metric to be perceived
  * Satisfaction - lead productivity metric
    * What to measure?
      * Whether developers recommend their team to others
      * Whether developers have tools resources
      * Burnout
  * Performance - hard to measure metric. Developer can write a lot of code, but it will be low quality code. High quality code can not deliver business value. etc.
    * What to measure?
      * reliability, absence of bugs, ongoing service health
      * customer satisfaction, customer adoption and retention, feature cost, cost reduction
  * Activity - almost impossible to comprehensively measure.
    * What to measure?
      * Volume of documents, pull requests, commits, code reviews
      * Count of builds, releases, IT infrastructure utilization
      * Count of incidents and distribution based on severity
  * Communication - Hard to measure because of "invisible" work
    * successful teams have high transparency, awareness about other team members activity and tasks priorities. 
    * Because all that raise chances that people will be working on a right problem.
    * Contribution to team productivity can come at expense of individual productivity.
    * What to measure?
      * how easy to find documentation and expertise
      * How fast work getting integrated
      * quality of code reviews
      * metrics showing who contacted whom
      * on-boarding time for new members
  * Efficiency - have common metrics with DORA (DevOps Research and Assessment) framework.
    * Positively correlated with satisfaction.
    * What to measure?
      * number of hand-offs in a process
      * perceived ability to stay in the flow
      * interruptions
      * waiting time
* SPACE and SRE
  * number of incidents resolved by individual is only one of the important metrics.
    * because incident management is a team activity
  * metrics context is important, multidimensional view to metrics is important.
    * example of IM (incident management) metrics: number of incidents, severity of those, resolution time.
  * culture in SRE is important as much as proper tools
  * Metrics:
    * Satisfaction:
      * how good is IM process, escalation, routing and on-call activities
    * Performance:
      * monitoring systems, ability to detect issue fast, MTTR
    * Activity:
      * number of issue captured by monitoring, number of incident resolved (and their severity distribution)
    * Communication:
      * how people communicated during the incident.
    * Efficiency:
      * number of hops an incident has to take before being assigned.

