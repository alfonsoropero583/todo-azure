# Configuración de Terraform para crear un grupo de recursos en Azure.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.93.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
  }
  # required_version = ">= 1.7.4"
}

# Proveedor de Azure Resource Manager para Terraform.
provider "azurerm" {
  features {}
}

# Recurso de grupo de recursos de Azure.
resource "azurerm_resource_group" "rg" {
  name     = "ClPr2"
  location = "eastus"
}