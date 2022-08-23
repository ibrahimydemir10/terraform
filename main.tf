

locals {
    resource_group_name = "Resource_Group_for_Test_BRO"
    location = "West Europe"
    virtual_network-linux = {
      name = "linux-network"
      address_space = "192.168.0.0/16"
    
    }
    virtual_network-windows = {
      name = "windows-networks"
      address_space = "172.24.0.0/16"
    
    }
    subnets =[
      {
        name = "subnetA"
        address_prefix = "10.0.0.0/24"
      },
      {
        name = "subnetB"
        address_prefix = "10.0.1.0/24"
      }

    ]
}
resource "azurerm_resource_group" "for_test_purposes" {
  name     = local.resource_group_name
  location = local.location
  
}




