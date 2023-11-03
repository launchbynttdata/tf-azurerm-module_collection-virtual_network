// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "network" {
  source = "../.."

  resource_group_name                                   = module.resource_group.name
  location                                              = var.region
  vnet_name                                             = local.vnet_name
  address_space                                         = var.address_space
  subnet_names                                          = [local.subnet_1_name, local.subnet_2_name]
  subnet_prefixes                                       = var.subnet_prefixes
  bgp_community                                         = var.bgp_community
  ddos_protection_plan                                  = var.ddos_protection_plan
  dns_servers                                           = var.dns_servers
  nsg_ids                                               = local.nsg_ids
  route_tables_ids                                      = var.route_tables_ids
  subnet_delegation                                     = var.subnet_delegation
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  subnet_enforce_private_link_service_network_policies  = var.subnet_enforce_private_link_service_network_policies
  subnet_service_endpoints                              = var.subnet_service_endpoints
  tags                                                  = var.tags
  tracing_tags_enabled                                  = var.tracing_tags_enabled
  tracing_tags_prefix                                   = var.tracing_tags_prefix
  use_for_each                                          = var.use_for_each

  depends_on = [module.resource_names, module.resource_group, module.network_security_group]

}
module "resource_group" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module-resource_group.git?ref=0.2.0"

  name     = local.resource_group_name
  location = var.region
  tags = {
    resource_name = local.resource_group_name
  }
}

# This module generates the resource-name of resources based on resource_type, naming_prefix, env etc.
module "resource_names" {
  source = "git::https://github.com/nexient-llc/tf-module-resource_name.git?ref=1.0.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", var.region))
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  instance_resource       = var.resource_number
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}

module "network_security_group" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-wrapper_module-security_group.git?ref=feature/external-module"

  for_each = local.network_security_groups

  resource_group_name = module.resource_group.name

  security_group_name = each.value.name
  location            = var.region
  tags                = each.value.tags

  custom_rules                 = each.value.custom_rules
  destination_address_prefix   = each.value.destination_address_prefix
  destination_address_prefixes = each.value.destination_address_prefixes
  predefined_rules             = each.value.predefined_rules
  rules                        = each.value.rules
  source_address_prefix        = each.value.source_address_prefix
  source_address_prefixes      = each.value.source_address_prefixes

  use_for_each = var.use_for_each

  depends_on = [module.resource_names, module.resource_group]
}
