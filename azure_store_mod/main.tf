resource "azurerm_resource_group" "rg" {
    name     = var.resource_grp_name
    location = var.rgrp_location
}

resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "azurerm_storage_account" "storage_mod" {
  name                          = "staccvm2"
  resource_group_name           = var.resource_grp_name
  location                      = var.rgrp_location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  # public_network_access_enabled = false

  tags = {
    environment = "staging"
  }
}

module "vm_mod" {
    source = "./azure_modules/vm_mod"
    rgrp_location            = var.rgrp_location
    resource_grp_name = var.resource_grp_name
    admin_usename = var.admin_usename
    my_storage_account_endpoint = azurerm_storage_account.storage_mod.primary_blob_endpoint
}