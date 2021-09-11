
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_public_ip" "ip" {
  name                         = "${var.name}-${var.env}-ip"
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  allocation_method            = "Dynamic"

  tags = {
      environment = var.env
  }
}

resource "azurerm_network_security_group" "sg" {
    name                = "${var.name}-${var.env}-sg"
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = data.azurerm_resource_group.rg.location

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.env
    }
}

resource "azurerm_network_interface" "interface" {
  name                = "${var.name}-${var.env}-interface"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "int_sg" {
    network_interface_id      = azurerm_network_interface.interface.id
    network_security_group_id = azurerm_network_security_group.sg.id
}

resource "azurerm_linux_virtual_machine" "instance" {
  name                = "${var.name}-${var.env}-instance"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = var.instance_size
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_key_file)
  }

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.disk_type
    disk_size_gb         = var.disk_size
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

