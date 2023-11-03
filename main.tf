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
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = var.resource_group_name
  use_for_each        = true
  vnet_location       = var.location

  address_space                                         = var.address_space
  bgp_community                                         = var.bgp_community
  ddos_protection_plan                                  = var.ddos_protection_plan
  nsg_ids                                               = var.nsg_ids
  route_tables_ids                                      = var.route_tables_ids
  subnet_delegation                                     = var.subnet_delegation
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  subnet_enforce_private_link_service_network_policies  = var.subnet_enforce_private_link_service_network_policies

  subnet_names = var.subnet_names

  subnet_prefixes          = var.subnet_prefixes
  subnet_service_endpoints = var.subnet_service_endpoints
  tags                     = var.tags
  tracing_tags_enabled     = var.tracing_tags_enabled
  tracing_tags_prefix      = var.tracing_tags_prefix
  dns_servers              = var.dns_servers

  vnet_name = var.vnet_name
}
