variable "vnet_name" {
    type         = string
    description  = "name of the virtual network"

}

variable "rp_location" {
    type        = string
    description = "resource group location"
    default = "us-east-1"

}

variable "resource_rp_name" {
    type        = string
    description = "resource group name"
}

variable "subnet_name" {
    type        = string
    description = "name of the subnet"
}


    
