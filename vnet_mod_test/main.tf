resource "random_pet" "test_rg_pet" {
    prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "test_rg_grp" {
    name = var.resource_grp_name
    location = var.rgrp_location
}

resource "azurerm_storage_account" "test_sa" {
    name                          = "staccvm5"
    resource_group_name           = azurerm_resource_group.test_rg_grp.name
    location                      = var.rgrp_location
    account_tier                  = "Standard"
    account_replication_type      = "GRS"

    tags = {
        environment = "staging"
    }
}

module "vnet_mod" {
    source = "./vnet_mod"
    vnet_name = "test_vnet"
    rp_location = var.rgrp_location
    resource_rp_name = azurerm_resource_group.test_rg_grp.name
    subnet_name = "test_subnet"

}

 
