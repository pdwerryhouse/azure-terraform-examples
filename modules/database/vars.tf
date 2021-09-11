variable "env" { }
variable "name" { }
variable "location" { }
variable "backup_retention_days" { default = "7" }
variable "db_name" { }
variable "storage_mb" { default = "5120" }
variable "username" { }
variable "password" { }
variable "rg_name" { }
variable "sku_name" { }
variable "pg_version" { default = "11" }
variable "charset" { default = "UTF8" }
variable "collation" { default = "States.1252" }
