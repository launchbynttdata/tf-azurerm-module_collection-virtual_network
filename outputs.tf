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
  value = { for name, vnet in module.network : name => vnet.vnet_name }
}

output "vnet_ids" {
  value = { for name, vnet in module.network : name => vnet.vnet_id }
}

output "vnet_subnets" {
  value = { for name, vnet in module.network : name => vnet.vnet_subnets }
}

output "vnet_locations" {
  value = { for name, vnet in module.network : name => vnet.vnet_location }
}

output "vnet_address_spaces" {
  value = { for name, vnet in module.network : name => vnet.vnet_address_space }
}

output "vnet_subnet_name_id_map" {
  description = "Outputs a subnet name to ID map for each Vnet"
  value       = { for name, vnet in module.network : name => vnet.vnet_subnets_name_id }
}
