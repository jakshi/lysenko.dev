+++
date = "2019-10-21T21:48:00+07:00"
description = ""
draft = false
tags = ["saltstack", "test-kitchen", "infrastructure-as-code", "testing"]
title = "Testing SaltStack code with test-kitchen — a 2019 snapshot"
aliases = ["/post/testing-saltstack-it-infrastucture-code-with-test-kitchen/"]
+++

> **Note (2026):** This post sat as a draft on my old DevOps blog from 2019. Migrating it here as-is, trimmed to what was actually finished. The original had two stub sections ("Serverspec examples next time", "pitfalls next time") that I never got back to — I've removed them rather than fake the content. Test-kitchen-salt and SaltStack are both still maintained, but the ecosystem has shifted toward Pulumi/Terraform/Ansible for most teams.

<!--more-->

## Test-kitchen in one paragraph

[test-kitchen](https://github.com/test-kitchen/test-kitchen) is the test harness Chef built originally, repurposed for any infrastructure-as-code tool. It:

- creates throwaway VMs (or containers)
- runs your IaC code inside them
- runs tests against the resulting state
- destroys the VMs

It has a plugin system, so you can swap the IaC tool (Salt, Chef, Ansible, Terraform) and the VM driver (AWS, GCP, VirtualBox, Docker) independently. Test frameworks plug in too: `testinfra`, `busser`, `InSpec`, `Serverspec`, or plain shell.

[test-kitchen-salt](https://github.com/saltstack/kitchen-salt) is the plugin that makes this work for SaltStack formulas and states.

## Prerequisites

- Ruby
- SaltStack
- test-kitchen
- test-kitchen-salt
- A VM driver (AWS, VirtualBox, Docker, GCP, etc.)

## Install

In the root of your salt repo (or formula repo), create a `Gemfile`:

```ruby
source 'https://rubygems.org'

group 'integration' do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-ec2'
  gem 'kitchen-salt'
  gem 'kitchen-sync' # faster file copy
  gem 'git'
end
```

Install:

```bash
bundle install --path vendor/bundle
bundle exec kitchen --version
```

## Daily commands

```bash
bundle exec kitchen list      # show suites and instances
bundle exec kitchen create    # spin up VMs
bundle exec kitchen converge  # apply your salt code
bundle exec kitchen verify    # run tests
bundle exec kitchen destroy   # tear down
```

Or all of the above in one shot:

```bash
bundle exec kitchen test
```

## References

- [test-kitchen](https://github.com/test-kitchen/test-kitchen)
- [kitchen-ec2](https://github.com/test-kitchen/kitchen-ec2)
- [kitchen-salt](https://github.com/saltstack/kitchen-salt)
