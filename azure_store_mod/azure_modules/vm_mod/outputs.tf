output "vnet_id" {
    description = "id of the network interface"
    value = azurerm_virtual_network.my_terraform_network.id
}

output "subnet_id2" {
    description = "id of the network interface"
    value = azurerm_subnet.my_terraform_subnet2.id 
}