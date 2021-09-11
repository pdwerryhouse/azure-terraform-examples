
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_virtual_network" "network" {
  name                = "${var.name}-${var.env}-network"
  address_space       = [ var.cidr_block ]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                = "${var.name}-${var.env}-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = [ cidrsubnet(var.cidr_block,8,0) ]
}


