
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_postgresql_server" "db" {
  name                          = "${var.name}-${var.env}-db"
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = var.location

  sku_name                      = var.sku_name

  storage_mb                    = var.storage_mb
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = false
  auto_grow_enabled             = true

  administrator_login           = var.username
  administrator_login_password  = var.password
  version                       = var.pg_version
  ssl_enforcement_enabled       = true
}

resource "azurerm_postgresql_database" "db" {
  name                = var.db_name
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.db.name
  charset             = var.charset
  collation           = var.collation
}

