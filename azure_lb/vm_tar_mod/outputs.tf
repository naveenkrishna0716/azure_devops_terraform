output "vnet_id" {
    description = "id of the network interface"
    value = azurerm_virtual_network.my_terraform_network.id
}

output "public_lb_id" {
    description = "ip of the public address"
    value = azurerm_public_ip.my_terraform_public_ip.id
}
output "nic_id" {
    description = "id of the network interface id"
    value = azurerm_network_interface.my_terraform_nic.id
}

output "nic_ip_name" {
    description = "id of the network interface id"
    value = azurerm_network_interface.my_terraform_nic.ip_configuration[0].name
}