resource "random_pet" {
 prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group"  {
    name = var.resource_grp_name
    location = var.rgrp_location
}

resource "azurerm_storage_account" {
    name                          = "staccvm5"
    resource_group_name           = var.resource_grp_name
    location                      = var.rgrp_location
    account_tier                  = "Standard"
    account_replication_type      = "GRS"

    tags = {
        environment = "staging"
    }
}

module "vnet_mod" {
    source = "./azure_store_mod/azu_mod/vnet_mod"
    vnet_name = "test_vnet"
    rp_location = var.rgrp_location
    resource_rp_name = var.resource_grp_name
    subnet_name = "test_subnet"

}

 
