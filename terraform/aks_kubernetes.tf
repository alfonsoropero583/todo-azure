# Recurso que define un Azure Kubernetes Service (AKS).
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "clasepractica-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "clasepractica-aks-dns"

  default_node_pool {
    name       = "poolnode"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_resource_group.rg]
}