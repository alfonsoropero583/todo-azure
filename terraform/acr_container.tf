# Recurso que define un Azure Container Registry (ACR).
resource "azurerm_container_registry" "acr" {
  name                = "acrD5fLwd1utqMa6PF"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true
}