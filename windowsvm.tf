/*
resource "azurerm_network_interface" "ibrahimnetworkinterface" {
  count = var.number_of_machines
  name                = "ibrahimnetwork-nic${count.index}"
  location            = local.location
  resource_group_name = local.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.app-ip[count.index].id
  }
  depends_on = [
    azurerm_subnet.subnets,
    azurerm_public_ip.app-ip
  ]
}

resource "azurerm_public_ip" "app-ip" {
  name                = "app-ip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]
}

resource "azurerm_network_security_group" "security-group" {
  name                = "security-group_for_windows"
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "rule1"
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

resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.security-group.id
  depends_on = [
    azurerm_network_security_group.security-group
  ]
}

resource "azurerm_windows_virtual_machine" "myVMibrahim" {
  name                = "myVMibrahim"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "myvm@1234"
  network_interface_ids = [
    azurerm_network_interface.ibrahimnetworkinterface.id
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
    azurerm_network_interface.ibrahimnetworkinterface
  ]
}

*/
