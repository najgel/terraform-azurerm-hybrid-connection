output "resource_group_name" {
  description = "The resource group name."
  value = "${azurerm_resource_group.hybrid_connection.name}"
}

output "location" {
  description = "The location/region where the resource group is created."
  value       = "${azurerm_resource_group.hybrid_connection.location}"
}

output "relay_name" {
  value = "${azurerm_template_deployment.hybrid_connection.outputs}"
}
