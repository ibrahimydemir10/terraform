

resource "azurerm_virtual_network" "linux-network" {
  name                = local.virtual_network-linux.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network-linux.address_space]
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]
}
resource "azurerm_virtual_network" "windows-network" {
  name                = local.virtual_network-windows.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network-windows.address_space]
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]
}
resource "azurerm_subnet" "subnets-linux" {
  count = var.number_of_linux_machines
  name                 = "Subnet-linux${count.index}"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network-linux.name
  address_prefixes     = ["192.168.${count.index}.0/24"]
  depends_on = [
    azurerm_virtual_network.linux-network
  ]
}

resource "azurerm_subnet" "subnets-windows" {
  count = var.number_of_windows_machines
  name                 = "Subnet-windows${count.index}"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network-windows.name
  address_prefixes     = ["172.24.${count.index}.0/24"]
  depends_on = [
    azurerm_virtual_network.windows-network
  ]
}

