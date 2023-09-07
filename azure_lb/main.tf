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

module "vm_tar_mod" {
    source = "./vm_tar_mod"
    rgrp_location            = var.rgrp_location
    resource_grp_name        = var.resource_grp_name
    admin_usename            = var.admin_usename
    my_storage_account_endpoint = azurerm_storage_account.storage_mod.primary_blob_endpoint
}

resource "azurerm_lb" "azure_load_balancer" {
  name                = "TestLoadBalancer"
  location            = var.rgrp_location
  resource_group_name = var.resource_grp_name

  frontend_ip_configuration {
    name                 = "front_end_IP_configuration_for_azure_load_balancer"
    public_ip_address_id = module.vm_tar_mod.public_lb_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  loadbalancer_id     = azurerm_lb.azure_load_balancer.id
  name                = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "network_interface_backend_address_pool_association" {
  network_interface_id    = module.vm_tar_mod.nic_id
  ip_configuration_name   = module.vm_tar_mod.nic_ip_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.id
}