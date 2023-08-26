resource "azurerm_virtual_network" "test_vrtl" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = var.rp_location
  resource_group_name = var.resource_rp_name

}

resource "azurerm_subnet" "test_subnet"{
  name                 = var.subnet_name
  resource_group_name  = var.resource_rp_name
  virtual_network_name = azurerm_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}