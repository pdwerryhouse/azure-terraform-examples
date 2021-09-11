
resource "azurerm_resource_group" "rg" {
  name = "${var.name}-${var.env}"
  location = var.location
}

