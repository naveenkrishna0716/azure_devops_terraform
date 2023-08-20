resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

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
  name                          = "staccvm3"
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

resource "azurerm_private_dns_zone" "my_prdns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_grp_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
  name                  = "vnet_link1"
  resource_group_name   = var.resource_grp_name
  private_dns_zone_name = azurerm_private_dns_zone.my_prdns.name
  virtual_network_id    = module.vm_mod.vnet_id
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = "my_pe1"
  location            = var.rgrp_location
  resource_group_name = var.resource_grp_name
  subnet_id           = module.vm_mod.subnet_id2


  private_service_connection {
    name                           = "pe_conn1"
    private_connection_resource_id = azurerm_storage_account.storage_mod.id 
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

resource "azurerm_private_dns_a_record" "dns_a" {
  name                = "my_dns"
  zone_name           = azurerm_private_dns_zone.my_prdns.name
  resource_group_name = var.resource_grp_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.endpoint.private_service_connection.0.private_ip_address]
}