# Complete example
 This module emulates a Hub and Spoke architecture model by creating multiple Vnets and subnets using same terraform module. Each Vnet is created in its own Resource Group. The Vnet attributes are configurable through the input parameters

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
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | git::https://github.com/launchbynttdata/tf-launch-module_library-resource_name.git | 1.0.0 |
| <a name="module_network"></a> [network](#module\_network) | ../.. | n/a |
| <a name="module_resource_groups"></a> [resource\_groups](#module\_resource\_groups) | git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-resource_group.git | 1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_map"></a> [network\_map](#input\_network\_map) | Map of spoke networks where vnet name is key, and value is object containing attributes to create a network | <pre>map(object({<br>    resource_group_name = optional(string)<br>    location            = optional(string)<br>    vnet_name           = optional(string)<br>    address_space       = list(string)<br>    subnet_names        = list(string)<br>    subnet_prefixes     = list(string)<br>    bgp_community       = string<br>    ddos_protection_plan = object(<br>      {<br>        enable = bool<br>        id     = string<br>      }<br>    )<br>    dns_servers                                           = list(string)<br>    nsg_ids                                               = map(string)<br>    route_tables_ids                                      = map(string)<br>    subnet_delegation                                     = map(map(any))<br>    subnet_enforce_private_link_endpoint_network_policies = map(bool)<br>    subnet_enforce_private_link_service_network_policies  = map(bool)<br>    subnet_service_endpoints                              = map(list(string))<br>    tags                                                  = map(string)<br>    tracing_tags_enabled                                  = bool<br>    tracing_tags_prefix                                   = string<br>    use_for_each                                          = bool<br>  }))</pre> | n/a | yes |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>    region     = optional(string, "eastus2")<br>  }))</pre> | <pre>{<br>  "hub_sbnt": {<br>    "max_length": 80,<br>    "name": "hubsbnt",<br>    "region": "eastus"<br>  },<br>  "hub_vnet": {<br>    "max_length": 80,<br>    "name": "hubvnet",<br>    "region": "eastus"<br>  },<br>  "resource_group_hub": {<br>    "max_length": 80,<br>    "name": "rg",<br>    "region": "eastus"<br>  },<br>  "resource_group_spoke1": {<br>    "max_length": 80,<br>    "name": "rg",<br>    "region": "eastus2"<br>  },<br>  "resource_group_spoke2": {<br>    "max_length": 80,<br>    "name": "rg",<br>    "region": "southindia"<br>  },<br>  "spoke1_sbnt": {<br>    "max_length": 80,<br>    "name": "spokesbnt",<br>    "region": "eastus2"<br>  },<br>  "spoke1_vnet": {<br>    "max_length": 80,<br>    "name": "spokevnet",<br>    "region": "eastus2"<br>  },<br>  "spoke2_sbnt": {<br>    "max_length": 80,<br>    "name": "spokesbnt",<br>    "region": "southindia"<br>  },<br>  "spoke2_vnet": {<br>    "max_length": 80,<br>    "name": "spokevnet",<br>    "region": "southindia"<br>  }<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"001"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"001"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"network"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

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
| <a name="output_rg_ids"></a> [rg\_ids](#output\_rg\_ids) | Map of Resource Group ids where key in input key in network map and value is id of resource group that got created. |
| <a name="output_rg_names"></a> [rg\_names](#output\_rg\_names) | Map of Resource Group Names where key in input key in network map and value is name of resource group that got created. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
