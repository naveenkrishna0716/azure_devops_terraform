resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "myVnet"
  address_space       =  ["10.0.0.0/16"]
  location            = var.rgrp_location
  resource_group_name = var.resource_grp_name 
}

resource "azurerm_subnet" "my_terraform_subnet1" {
  name                 = "mySubnet1"
  resource_group_name  = var.resource_grp_name 
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "my_terraform_subnet2" {
  name                 = "mySubnet2"
  resource_group_name  = var.resource_grp_name 
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.2.0/24"]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "my_terraform_subnet3" {
  name                 = "mySubnet3"
  resource_group_name  = var.resource_grp_name 
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "my_terraform_subnet4" {
  name                 = "mySubnet4"
  resource_group_name  = var.resource_grp_name 
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "myPublicIP"
  location            = var.rgrp_location
  resource_group_name = var.resource_grp_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "my_terraform_nic" {
  name                = "myNIC"
  location            = var.rgrp_location
  resource_group_name = var.resource_grp_name
}

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip.id
  }

resource "azurerm_windows_virtual_machine" "vm" {
    name                  = "vm1_windows1"
    resource_group_name   = var.resource_grp_name  
    location              = var.rgrp_location
    size                  = "Standard_DS1_v2"
    admin_username        = var.admin_usename
    admin_password        = random_password.password.result
    network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
    os_disk {
        name                    = "myOsDisk"
        caching                 = "ReadWrite"
        storage_account_type    = "Premium_LRS"
    }
    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-datacenter-azure-edition"
        version   = "latest"
    }
    computer_name  = "hostname"

   boot_diagnostics {
    storage_account_uri = var.my_storage_account_endpoint
  }
}
