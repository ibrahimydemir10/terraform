resource "azurerm_network_interface" "ibrahimnetworkinterface-windows" {
  count = var.number_of_windows_machines
  name                = "ibrahimnetwork-nic${count.index}-windows"
  location            = local.location
  resource_group_name = local.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets-windows[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.app-ip-windows[count.index].id
  }
  depends_on = [
    azurerm_subnet.subnets-windows,
    azurerm_public_ip.app-ip-windows
  ]
}

resource "azurerm_public_ip" "app-ip-windows" {
  count = var.number_of_windows_machines
  name                = "app-ip-windows${count.index}"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]
}


resource "azurerm_network_security_group" "security-groupwindows" {
  count = var.number_of_windows_machines
  name                = "security-group_for_windows${count.index}"
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "RDP_RULE"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]


}

resource "azurerm_subnet_network_security_group_association" "associationforwindows" {
  count = var.number_of_windows_machines
  subnet_id                 = azurerm_subnet.subnets-windows[count.index].id
  network_security_group_id = azurerm_network_security_group.security-groupwindows[count.index].id
  depends_on = [
    azurerm_network_security_group.security-groupwindows,
    azurerm_subnet.subnets-windows
  ]
}

resource "azurerm_windows_virtual_machine" "myVMibrahim" {
  count = var.number_of_windows_machines
  name                = "myVMibrahim${count.index}"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.password.value
  network_interface_ids = [
    azurerm_network_interface.ibrahimnetworkinterface-windows[count.index].id
]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.ibrahimnetworkinterface-windows
  ]
}
