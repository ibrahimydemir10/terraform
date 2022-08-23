/*
resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = "linux-machine"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linuxnetworkinterface.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.linuxkey.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.linuxnetworkinterface,
    azurerm_resource_group.for_test_purposes,
    tls_private_key.linuxkey
  ]
}
resource "azurerm_network_interface" "linuxnetworkinterface" {
  name                = "linux-network-nic"
  location            = local.location
  resource_group_name = local.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetB.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.app-ip2.id
  }
  depends_on = [
    azurerm_subnet.subnetB,
    azurerm_public_ip.app-ip2
  ]
}

resource "azurerm_public_ip" "app-ip2" {
  name                = "app-ip2"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]
}

resource "azurerm_network_security_group" "security-grouplinux" {
  name                = "security-group_for_linux"
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "sshrule"
    priority                   = 350
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]


}

resource "azurerm_subnet_network_security_group_association" "associationforlinux" {
  subnet_id                 = azurerm_subnet.subnetB.id
  network_security_group_id = azurerm_network_security_group.security-grouplinux.id
  depends_on = [
    azurerm_network_security_group.security-grouplinux
  ]
}

resource "tls_private_key" "linuxkey" {
  algorithm = "RSA"
  rsa_bits = 4096
  
}
resource "local_file" "linuxpemkey" {
  filename = "linuxkey.pem"
  content = tls_private_key.linuxkey.private_key_pem
  depends_on = [
    tls_private_key.linuxkey
  ]
}
*/