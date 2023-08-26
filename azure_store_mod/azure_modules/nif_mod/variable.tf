variable "resource_rg_name" {
    default= "modresourcegrp"
    type = string
    description = "name of the resource group"
}
variable "rg_location" {
    default     = "eastus"
    type = string
    description = "Azure location"
}
