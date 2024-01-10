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

variable "network_map" {
  description = "Map of spoke networks where vnet name is key, and value is object containing attributes to create a network"
  type = map(object({
    resource_group_name = string
    location            = string
    vnet_name           = string
    address_space       = list(string)
    subnet_names        = list(string)
    subnet_prefixes     = list(string)
    bgp_community       = string
    ddos_protection_plan = object(
      {
        enable = bool
        id     = string
      }
    )
    dns_servers                                           = list(string)
    nsg_ids                                               = map(string)
    route_tables_ids                                      = map(string)
    subnet_delegation                                     = map(map(any))
    subnet_enforce_private_link_endpoint_network_policies = map(bool)
    subnet_enforce_private_link_service_network_policies  = map(bool)
    subnet_service_endpoints                              = map(list(string))
    tags                                                  = map(string)
    tracing_tags_enabled                                  = bool
    tracing_tags_prefix                                   = string
    use_for_each                                          = bool
  }))
}
