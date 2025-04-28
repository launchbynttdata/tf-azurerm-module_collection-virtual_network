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

//outputs by network module
output "networks" {
  value       = module.network
  description = "The output of the network module"
}

output "vnet_names" {
  value       = { for k, v in var.network_map : k => module.network[k].vnet_name }
  description = "Map of vnet names where key in input key in network map and value is name of vnet that got created."
}

output "vnet_ids" {
  value       = { for k, v in var.network_map : k => module.network[k].vnet_id }
  description = "Map of vnet names where key in input key in network map and value is id of vnet that got created."
}

output "vnet_subnets" {
  value       = { for k, v in var.network_map : k => module.network[k].subnet_map }
  description = "Map of vnet names where key in input key in network map and value is id of the subnets that got created."
}

output "vnet_locations" {
  value       = { for k, v in var.network_map : k => module.network[k].vnet_location }
  description = "Map of vnet names where key in input key in network map and value is location of vnet that got created."
}

output "vnet_address_spaces" {
  value       = { for k, v in var.network_map : k => module.network[k].vnet_address_space }
  description = "Map of vnet names where key in input key in network map and value is address of vnet that got created."
}

output "vnet_subnet_name_id_map" {
  description = "Outputs a subnet name to ID map for each Vnet"
  value       = { for k, v in var.network_map : k => module.network[k].subnet_name_id_map }
}

output "vnet_subnet_name_id_map_flattened" {
  description = "Flattened map of subnet names to ids for iterating in dependent modules."
  value = {
    for item in flatten([
      for k, v in var.network_map : [
        for subnet_name, subnet_id in module.network[k].subnet_name_id_map : {
          key   = subnet_name
          value = subnet_id
        }
      ]
    ]) : item.key => item.value
  }
}
