terraform {
  required_providers {
    azurerm = {
      source = "azurerm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

module "resource_group" {
  source = "../../modules/resource_group"
  
  name            = var.name
  env             = var.env
  location        = var.location
}

module "network" {
  source = "../../modules/network"

  name            = var.name
  env             = var.env
  cidr_block      = var.cidr_block
  rg_name         = module.resource_group.rg_name

  depends_on      = [ module.resource_group ]
}

module "compute" {
  count = 0
  source = "../../modules/compute"

  env             = var.env
  disk_size       = var.compute_disk_size
  instance_size   = var.compute_instance_size
  name            = var.name
  rg_name         = module.resource_group.rg_name
  ssh_key_file    = var.ssh_key_file
  subnet_id       = module.network.subnet_id
  username        = var.compute_username

  depends_on      = [ module.resource_group, module.network ]
}

module "database" {
  count = 1
  source = "../../modules/database"

  env             = var.env
  name            = var.name
  location        = var.location
  rg_name         = module.resource_group.rg_name
  db_name         = var.database_name
  sku_name        = var.database_sku_name
  username        = var.database_username
  password        = var.database_password

  depends_on      = [ module.resource_group, module.network ]
}
