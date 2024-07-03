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
  source  = "terraform.registry.launch.nttdata.com/module_primitive/virtual_network/azurerm"
  version = "~> 1.0"

  for_each = var.network_map

  resource_group_name                                   = each.value.resource_group_name
  vnet_location                                         = each.value.location
  vnet_name                                             = each.value.vnet_name
  address_space                                         = each.value.address_space
  subnet_names                                          = each.value.subnet_names
  subnet_prefixes                                       = each.value.subnet_prefixes
  bgp_community                                         = each.value.bgp_community
  ddos_protection_plan                                  = each.value.ddos_protection_plan
  dns_servers                                           = each.value.dns_servers
  nsg_ids                                               = each.value.nsg_ids
  route_tables_ids                                      = each.value.route_tables_ids
  subnet_delegation                                     = each.value.subnet_delegation
  subnet_enforce_private_link_endpoint_network_policies = each.value.subnet_enforce_private_link_endpoint_network_policies
  subnet_enforce_private_link_service_network_policies  = each.value.subnet_enforce_private_link_service_network_policies
  subnet_service_endpoints                              = each.value.subnet_service_endpoints
  tags                                                  = each.value.tags
  tracing_tags_enabled                                  = each.value.tracing_tags_enabled
  tracing_tags_prefix                                   = each.value.tracing_tags_prefix
  use_for_each                                          = each.value.use_for_each
}
