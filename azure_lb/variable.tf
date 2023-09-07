variable "resource_grp_name" {
    default     = "lbrgp"
    type        = string
    description = "name of the resource group"
}

variable "resource_group_name_prefix" {
  default     = "lg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}
variable "rgrp_location" {
    default     = "eastus"
    type = string
    description = "Azure location"
}

variable "admin_usename" {
    default  = "azureadmin"
    type = string
    description = "local admin user of the virtual machine"
}