variable "cidr_block" { }
variable "compute_disk_size" { default = "30" }
variable "compute_instance_size" { default = "Standard_F2" }
variable "compute_username" { }
variable "database_name" { }
variable "database_sku_name" { }
variable "database_username" { }
variable "database_password" { }
variable "env" { }
variable "location" { }
variable "name" { }
variable "ssh_key_file" { }
variable "use_compute_module" { default = true }
variable "use_database_module" { default = true }
