resource_names_map = {
  hub_rg = {
    name       = "rg"
    max_length = 80
    region     = "eastus"
  }
  spoke1_rg = {
    name       = "rg"
    max_length = 80
    region     = "eastus2"
  }
  spoke2_rg = {
    name       = "rg"
    max_length = 80
    region     = "southindia"
  }
  hub_vnet = {
    name       = "vnet"
    max_length = 80
    region     = "eastus"
  }
  spoke1_vnet = {
    name       = "vnet"
    max_length = 80
    region     = "eastus2"
  }
  spoke2_vnet = {
    name       = "vnet"
    max_length = 80
    region     = "southindia"
  }
}

# vnet_name and vnet_location will be injected inside the module
network_map = {
  "spoke1" = {
    address_space = ["192.0.0.0/16"]
    subnets = {
      AzureBastionSubnet = {
        prefix = "192.0.0.0/24"
      }
    }
    bgp_community        = null
    ddos_protection_plan = null
    dns_servers          = []
    tags                 = {}
  },
  "spoke2" = {
    address_space = ["172.0.0.0/16"]
    subnets = {
      subnet-1 = {
        prefix = "172.0.10.0/24"
      }
    }
    bgp_community        = null
    ddos_protection_plan = null
    dns_servers          = []
    tags                 = {}
  },
  "hub" = {
    address_space = ["10.0.0.0/16"]
    subnets = {
      AzureFirewallSubnet = {
        prefix = "10.0.0.0/24"
      }
    }
    bgp_community        = null
    ddos_protection_plan = null
    dns_servers          = []
    tags                 = {}
  }
}
