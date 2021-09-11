variable "env" { }
variable "disk_caching" { default = "ReadWrite" }
variable "disk_type" { default = "Standard_LRS" }
variable "disk_size" { }
variable "instance_size" { }
variable "name" { }
variable "rg_name" { }
variable "ssh_key_file" { }
variable "subnet_id" { }
variable "username" { }
variable "image_publisher" { default = "Canonical" }
variable "image_offer" { default = "UbuntuServer" }
variable "image_sku" { default = "18.04-LTS" }
variable "image_version" { default = "latest" }
