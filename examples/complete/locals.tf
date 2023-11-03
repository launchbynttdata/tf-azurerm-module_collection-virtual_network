locals {
  resource_group_name = module.resource_names["resource_group"].minimal_random_suffix
  vnet_name           = module.resource_names["virtual_network"].minimal_random_suffix
  subnet_1_name       = "public-subnet"
  subnet_2_name       = "private-subnet"

  nsg_ids = {
    for subnet in [local.subnet_1_name, local.subnet_2_name] : subnet => module.network_security_group[subnet].network_security_group_id
  }

  network_security_groups = {
    "${local.subnet_1_name}" = {
      name = "public-subnet-nsg"
      tags = {
        environment = "dev"
      }
      custom_rules = [{
        name                       = "allow-rdp"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_address_prefix = "*"
        destination_port_range     = "3089"
        description                = "allow-rdp on all vms in subnet"
        source_port_range          = "*"
        source_address_prefix      = "*"
        },
        {
          name                       = "allow-http"
          priority                   = 102
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          destination_address_prefix = "*"
          destination_port_range     = "80"
          description                = "allow-http on all vms in subnet"
          source_port_range          = "*"
          source_address_prefix      = "*"
        }
      ],
      destination_address_prefix   = []
      destination_address_prefixes = []
      predefined_rules             = []
      rules                        = {}
      source_address_prefix        = []
      source_address_prefixes      = []
    },
    "${local.subnet_2_name}" = {
      name = "private-subnet-nsg"
      tags = {
        environment = "dev"
      }
      custom_rules                 = []
      destination_address_prefix   = []
      destination_address_prefixes = []
      predefined_rules             = []
      rules                        = {}
      source_address_prefix        = []
      source_address_prefixes      = []
    }
  }
}
