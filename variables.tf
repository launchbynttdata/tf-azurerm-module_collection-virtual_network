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
    use_for_each        = bool
    address_space       = optional(list(string), ["10.0.0.0/16"])
    subnet_names        = optional(list(string), ["subnet1", "subnet2", "subnet3"])
    subnet_prefixes     = optional(list(string), ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"])
    bgp_community       = optional(string, null)
    ddos_protection_plan = optional(object(
      {
        enable = bool
        id     = string
      }
    ), null)
    dns_servers                                           = optional(list(string), [])
    nsg_ids                                               = optional(map(string), {})
    route_tables_ids                                      = optional(map(string), {})
    subnet_delegation                                     = optional(map(map(any)), {})
    subnet_enforce_private_link_endpoint_network_policies = optional(map(bool), {})
    subnet_enforce_private_link_service_network_policies  = optional(map(bool), {})
    subnet_service_endpoints                              = optional(map(list(string)), {})
    tags                                                  = optional(map(string), {})
    tracing_tags_enabled                                  = optional(bool, false)
    tracing_tags_prefix                                   = optional(string, "")
  }))
}
