# tf-azurerm-collection_module-virtual_network

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module is used to deploy one or more virtual networks and subnets.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | terraform.registry.launch.nttdata.com/module_primitive/virtual_network/azurerm | ~> 3.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_map"></a> [network\_map](#input\_network\_map) | Map of spoke networks where vnet name is key, and value is object containing attributes to create a network | <pre>map(object({<br>    resource_group_name = string<br>    location            = string<br>    vnet_name           = string<br>    address_space       = optional(list(string), ["10.0.0.0/16"])<br>    subnets = map(object({<br>      prefix = string<br>      delegation = optional(map(object({<br>        service_name    = string<br>        service_actions = list(string)<br>      })), {})<br>      service_endpoints                             = optional(list(string), []),<br>      private_endpoint_network_policies_enabled     = optional(bool, false)<br>      private_link_service_network_policies_enabled = optional(bool, false)<br>      network_security_group_id                     = optional(string, null)<br>      route_table_id                                = optional(string, null)<br>    }))<br>    bgp_community = optional(string, null)<br>    ddos_protection_plan = optional(object(<br>      {<br>        enable = bool<br>        id     = string<br>      }<br>    ), null)<br>    dns_servers      = optional(list(string), [])<br>    nsg_ids          = optional(map(string), {})<br>    route_tables_ids = optional(map(string), {})<br>    tags             = optional(map(string), {})<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_networks"></a> [networks](#output\_networks) | The output of the network module |
| <a name="output_vnet_names"></a> [vnet\_names](#output\_vnet\_names) | Map of vnet names where key in input key in network map and value is name of vnet that got created. |
| <a name="output_vnet_ids"></a> [vnet\_ids](#output\_vnet\_ids) | Map of vnet names where key in input key in network map and value is id of vnet that got created. |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets) | Map of vnet names where key in input key in network map and value is id of the subnets that got created. |
| <a name="output_vnet_locations"></a> [vnet\_locations](#output\_vnet\_locations) | Map of vnet names where key in input key in network map and value is location of vnet that got created. |
| <a name="output_vnet_address_spaces"></a> [vnet\_address\_spaces](#output\_vnet\_address\_spaces) | Map of vnet names where key in input key in network map and value is address of vnet that got created. |
| <a name="output_vnet_subnet_name_id_map"></a> [vnet\_subnet\_name\_id\_map](#output\_vnet\_subnet\_name\_id\_map) | Outputs a subnet name to ID map for each Vnet |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
