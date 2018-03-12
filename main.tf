resource "azurerm_resource_group" "hybrid_connection" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_template_deployment" "hybrid_connection" {
  name                = "${format("%v-deployment", var.hybrid_connection_name)}"
  resource_group_name = "${azurerm_resource_group.hybrid_connection.name}"

  template_body = <<DEPLOY
{
  "$schema": "http://schema.management.azure.com/schemas/2014-04-01-preview/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "relayName": {
      "type": "string"
    },
    "hybridConnectionName": {
      "type": "string"
    },
    "endpointHost": {
      "type": "string"
    },
    "endpointPort": {
      "type": "string"
    },
    "location": {
      "type": "string"
    }
  },
  "resources": [
    {
      "apiVersion": "2016-07-01",
      "name": "[parameters('relayName')]",
      "location": "[parameters('location')]",
      "type": "Microsoft.Relay/namespaces",
      "properties": {
        "namespaceType": "Relay"
      },
      "resources": [
        {
          "apiVersion": "2016-07-01",
          "name": "[parameters('hybridConnectionName')]",
          "type": "HybridConnections",
          "dependsOn": [
            "[concat('Microsoft.Relay/namespaces/', parameters('relayName'))]"
          ],
          "properties": {
            "requiresClientAuthorization": "true",
            "userMetadata": "[concat('[{\"key\":\"endpoint\",\"value\":\"', parameters('endpointHost'), ':', parameters('endpointPort'), '\"}]')]"
          }
        }
      ] 
    }
  ]
}
DEPLOY

  parameters {
    "relayName"            = "${var.relay_name}"
    "hybridConnectionName" = "${var.hybrid_connection_name}"
    "endpointHost"         = "${var.endpoint_host}"
    "endpointPort"         = "${var.endpoint_port}"
    "location"             = "${azurerm_resource_group.hybrid_connection.location}"
  }

  deployment_mode = "Incremental"

  lifecycle {
    create_before_destroy = true
  }

}
