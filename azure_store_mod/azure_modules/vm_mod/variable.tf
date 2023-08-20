variable "resource_grp_name" {
    default= "modresourcegrp"
    type = string
    description = "name of the resource group"
}
variable "rgrp_location" {
    default     = "eastus"
    type = string
    description = "Azure location"
}

variable "my_storage_account_endpoint" {
    type = string
    description = "Azure location"
}

variable "admin_usename" {
    default  = "azureadmin"
    type = string
    description = "local admin user of the virtual machine"
}