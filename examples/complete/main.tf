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

  network_map = local.network_map

  depends_on = [module.resource_group_hub, module.resource_group_spoke1, module.resource_group_spoke2]
}

module "resource_group_hub" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module-resource_group.git?ref=0.2.0"

  name     = local.resource_group_hub
  location = local.hub_location
  tags = {
    resource_name = local.resource_group_hub
  }
}

module "resource_group_spoke1" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module-resource_group.git?ref=0.2.0"

  name     = local.resource_group_spoke1
  location = local.spoke1_location
  tags = {
    resource_name = local.resource_group_spoke1
  }
}

module "resource_group_spoke2" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module-resource_group.git?ref=0.2.0"

  name     = local.resource_group_spoke2
  location = local.spoke2_location
  tags = {
    resource_name = local.resource_group_spoke2
  }
}

# This module generates the resource-name of resources based on resource_type, naming_prefix, env etc.
module "resource_names" {
  source = "git::https://github.com/nexient-llc/tf-module-resource_name.git?ref=1.0.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", each.value.region))
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  instance_resource       = var.resource_number
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}
