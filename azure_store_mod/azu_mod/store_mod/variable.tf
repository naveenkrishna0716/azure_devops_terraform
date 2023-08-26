variable "resource_rs_name" {
    default= "modresourcegrp"
    type = string
    description = "name of the resource group"
}
variable "rs_location" {
    default     = "eastus"
    type = string
    description = "Azure location"
}