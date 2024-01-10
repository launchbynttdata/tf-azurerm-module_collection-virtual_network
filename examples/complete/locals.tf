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
locals {
  resource_group_hub    = module.resource_names["resource_group_hub"].standard
  resource_group_spoke1 = module.resource_names["resource_group_spoke1"].standard
  resource_group_spoke2 = module.resource_names["resource_group_spoke2"].standard

  hub_vnet_name    = module.resource_names["hub_vnet"].standard
  spoke1_vnet_name = module.resource_names["spoke1_vnet"].standard
  spoke2_vnet_name = module.resource_names["spoke2_vnet"].standard

  hub_sbnt_name    = module.resource_names["hub_sbnt"].standard
  spoke1_sbnt_name = module.resource_names["spoke1_sbnt"].standard
  spoke2_sbnt_name = module.resource_names["spoke2_sbnt"].standard

  hub_location    = "eastus"
  spoke1_location = "eastus2"
  spoke2_location = "southindia"

  hub_network_details    = lookup(var.network_map, "hub")
  spoke1_network_details = lookup(var.network_map, "spoke1")
  spoke2_network_details = lookup(var.network_map, "spoke2")

  modified_hub_network = merge(local.hub_network_details, {
    resource_group_name = local.resource_group_hub
    location            = local.hub_location
    vnet_name           = local.hub_vnet_name
  })

  modified_spoke1_network = merge(local.spoke1_network_details, {
    resource_group_name = local.resource_group_spoke1
    location            = local.spoke1_location
    vnet_name           = local.spoke1_vnet_name
    subnet_names        = concat(local.spoke1_network_details.subnet_names, [local.spoke1_sbnt_name])
    subnet_prefixes     = concat(local.spoke1_network_details.subnet_prefixes, ["192.0.1.0/24"])
  })

  modified_spoke2_network = merge(local.spoke2_network_details, {
    resource_group_name = local.resource_group_spoke2
    location            = local.spoke2_location
    vnet_name           = local.spoke2_vnet_name
    subnet_names        = concat(local.spoke2_network_details.subnet_names, [local.spoke2_sbnt_name])
    subnet_prefixes     = concat(local.spoke2_network_details.subnet_prefixes, ["172.0.0.0/24"])
  })

  network_map = merge(var.network_map, {
    hub    = local.modified_hub_network,
    spoke1 = local.modified_spoke1_network,
    spoke2 = local.modified_spoke2_network
  })
}
