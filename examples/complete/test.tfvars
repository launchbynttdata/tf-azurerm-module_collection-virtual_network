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
    address_space                                         = ["192.0.0.0/16"]
    subnet_names                                          = ["AzureBastionSubnet"]
    subnet_prefixes                                       = ["192.0.0.0/24"]
    bgp_community                                         = null
    ddos_protection_plan                                  = null
    dns_servers                                           = []
    nsg_ids                                               = {}
    route_tables_ids                                      = {}
    subnet_delegation                                     = {}
    subnet_enforce_private_link_endpoint_network_policies = {}
    subnet_enforce_private_link_service_network_policies  = {}
    subnet_service_endpoints                              = {}
    tags                                                  = {}
    tracing_tags_enabled                                  = false
    tracing_tags_prefix                                   = ""
    use_for_each                                          = true
  },
  "spoke2" = {
    address_space                                         = ["172.0.0.0/16"]
    subnet_names                                          = ["subnet-1"]
    subnet_prefixes                                       = ["172.0.10.0/24"]
    bgp_community                                         = null
    ddos_protection_plan                                  = null
    dns_servers                                           = []
    nsg_ids                                               = {}
    route_tables_ids                                      = {}
    subnet_delegation                                     = {}
    subnet_enforce_private_link_endpoint_network_policies = {}
    subnet_enforce_private_link_service_network_policies  = {}
    subnet_service_endpoints                              = {}
    tags                                                  = {}
    tracing_tags_enabled                                  = false
    tracing_tags_prefix                                   = ""
    use_for_each                                          = true
  },
  "hub" = {
    address_space                                         = ["10.0.0.0/16"]
    subnet_names                                          = ["AzureFirewallSubnet"]
    subnet_prefixes                                       = ["10.0.0.0/24"]
    bgp_community                                         = null
    ddos_protection_plan                                  = null
    dns_servers                                           = []
    nsg_ids                                               = {}
    route_tables_ids                                      = {}
    subnet_delegation                                     = {}
    subnet_enforce_private_link_endpoint_network_policies = {}
    subnet_enforce_private_link_service_network_policies  = {}
    subnet_service_endpoints                              = {}
    tags                                                  = {}
    tracing_tags_enabled                                  = false
    tracing_tags_prefix                                   = ""
    use_for_each                                          = true
  }
}
