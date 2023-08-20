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
    location            = var.rgrp_location
    resource_group_name = var.resource_grp_name
    admin_username = var.admin_usename
    storage_account_uri = azurerm_storage_account.storage_mod.primary_blob_endpoint
}