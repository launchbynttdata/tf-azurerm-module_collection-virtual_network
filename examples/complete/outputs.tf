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
  value       = module.network.vnet_names
  description = "Map of vnet names where key in input key in network map and value is name of vnet that got created."
}

output "vnet_ids" {
  value       = module.network.vnet_ids
  description = "Map of vnet names where key in input key in network map and value is id of vnet that got created."
}

output "vnet_subnets" {
  value       = module.network.vnet_subnets
  description = "Map of vnet names where key in input key in network map and value is id of the subnets that got created."
}

output "vnet_locations" {
  value       = module.network.vnet_locations
  description = "Map of vnet names where key in input key in network map and value is location of vnet that got created."
}

output "vnet_address_spaces" {
  value       = module.network.vnet_address_spaces
  description = "Map of vnet names where key in input key in network map and value is address of vnet that got created."
}

output "vnet_subnet_name_id_map" {
  description = "Outputs a subnet name to ID map for each Vnet"
  value       = module.network.vnet_subnet_name_id_map
}

output "rg_ids" {
  description = "Map of Resource Group ids where key in input key in network map and value is id of resource group that got created."
  value       = { for k, v in local.modified_network_map : k => module.resource_groups[k].id }
}

output "rg_names" {
  description = "Map of Resource Group Names where key in input key in network map and value is name of resource group that got created."
  value       = { for k, v in local.modified_network_map : k => module.resource_groups[k].name }
}
