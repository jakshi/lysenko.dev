+++
date = "2024-01-14T17:11:00+07:00"
description = ""
draft = false
tags = ["terraform", "terragrunt", "code generation", "how-to"]
title = "Terraform dynamic code generation with terragrunt"
topics = []

+++

# Intro

This story started when I wanted to apply external `terraform` module to multiple AWS accounts.  
Note: module, variable names and AWS account names are changed to protect innocents.

<!--more-->

You can declare multiple providers in terraform like that:

```hcl
provider "aws" {
  profile = "companyname-production"
  alias  = "companyname-production"
  region = "ap-southeast-1"
}

provider "aws" {
  profile = "companyname-development"
  alias  = "companyname-development"
  region = "ap-southeast-1"
}

...
```

And then pass the provider alias to the module:

```hcl
module "terraform_external_module_companyname_production" {
  source              = "git::https://github.com/companyname/terraform-external-module.git?ref=main"
  providers = {
    aws = aws.companyname-production
  }
}

module "terraform_external_module_companyname_development" {
  source              = "git::https://github.com/companyname/terraform-external-module.git?ref=main"
  providers = {
    aws = aws.companyname-development
  }
}

...
```

Problem is that I have 10+ AWS accounts and I really don't want to repeat myself 10+ times.

So - let's use `for_each` to iterate over the accounts?  
But, alas, `for_each` can't be used with providers in terraform.

There is a long thread in terraform issue tracker on github about that: [Ability to pass providers to modules in for_each #24476](https://github.com/hashicorp/terraform/issues/24476)

In our company we already use a `terragrunt` wrapper for `terraform` to make terraform remote state management DRY.

If you wonder what is `terragrunt`, it's essentially [a DRY tool for terraform](https://terragrunt.gruntwork.io/).  
Or in other words, preprocessor for `terraform`.

So I started to look through `terragrunt` documentation, because, well, if it's a preprocessor,  
then as it executes before `terraform` - there's a good chance it can do what I want.  
And I found that `terragrunt` code generation feature.

The rest is techincal details.

# Terragrunt "technical details" of the code generation for terraform

Terragrunt can generate `terraform` code from Golang templates.  
Code need to be placed in `terragrunt.hcl` file.

Here's the example of the code generation:

```hcl
include {
  path = find_in_parent_folders()
}

locals {
  aws_accounts = {
    "companyname-production" = {
      myvariable = "value1"
    }
    "companyname-development" = {
      myvariable = "value2"
    }
  }

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite" # I want to have one source of truth for providers
  contents =  templatefile("providers.tf.tmpl", {
    aws_accounts = local.aws_accounts
  })
}

generate "modules" {
  path     = "modules.tf"
  if_exists = "overwrite" # I want to have one source of truth for modules
  contents = templatefile("modules.tf.tmpl", {
    aws_accounts = local.aws_accounts
  })
}
```

And here's the example of the `providers.tf.tmpl` template:

```hcl
%{ for profile, data in aws_accounts ~}
provider "aws" {
  profile = "${profile}"
  alias  = "${profile}"
  region = "ap-southeast-1"
}


%{~ endfor }
```

And here's the example of the `modules.tf.tmpl` template:

```hcl
%{ for profile, data in aws_accounts ~}

module "terraform_external_module_${replace(profile, "-", "_")}" {
  source              = "git::https://github.com/companyname/terraform-external-module.git?ref=main"
  config = "${data.myvariable}"
  providers = {
    aws = aws.${profile}
  }
}

%{~ endfor }
```

# How to run it
After that we can run terragrunt commands as usual:

```bash
terragrunt init
terragrunt plan
terragrunt apply
```

And it happily generates terraform code to `providers.tf` and `modules.tf` files for us.

# Conclusion

That's just one of the possible use cases for terragrunt code generation.
Possibilities to DRY your terraform code with terragrunt code generation are quite vast.

But don't forget about KISS principle when you are chasing the DRY principle :)

# References

* Ability to pass providers to modules in for_each #24476: https://github.com/hashicorp/terraform/issues/24476
* [Terragrunt](https://terragrunt.gruntwork.io/).
- [Terragrunt code generation](https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#generate)
