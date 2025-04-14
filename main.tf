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
  version = "~> 3.0"

  for_each = var.network_map

  resource_group_name  = each.value.resource_group_name
  vnet_location        = each.value.location
  vnet_name            = each.value.vnet_name
  address_space        = each.value.address_space
  subnets              = each.value.subnets
  bgp_community        = each.value.bgp_community
  ddos_protection_plan = each.value.ddos_protection_plan
  dns_servers          = each.value.dns_servers
  tags                 = each.value.tags
}
