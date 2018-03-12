variable "resource_group_name" {
  description = "The name of the resource group in which to create the App Service Plan component."
}

variable "location" {
  description = "Specifies the supported Azure location where the resource is to be created."
}

variable "relay_name" {
  description = "Specifies the name of the Relay component."
}

variable "hybrid_connection_name" {
  description = "Specifies the name of the Hybrid Connection component."
}

variable "endpoint_host" {
  description = "Specifies the endpoint host."
}

variable "endpoint_port" {
  description = "Specifies the endpoint port."
}
