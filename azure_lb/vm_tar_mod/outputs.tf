output "vnet_id" {
    description = "id of the network interface"
    value = azurerm_virtual_network.my_terraform_network.id
}

output "subnet_id2" {
    description = "id of the network interface"
    value = azurerm_subnet.my_terraform_subnet2.id 
}

output "nic_id" {
    description = "id of the network interface id"
    value = azurerm_network_interface.my_terraform_nic.id
}

output "nic_ip_name" {
    description = "id of the network interface id"
    value = azurerm_network_interface.my_terraform_nic.ip_configuration.name
}