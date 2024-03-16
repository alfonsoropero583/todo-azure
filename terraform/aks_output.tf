output "aks_kube_config" {
    value = azurerm_kubernetes_cluster.aks.kube_config_raw
    sensitive = true
}

output "aks_username" {
    value = azurerm_kubernetes_cluster.aks.kube_config[0].username
    sensitive = true
}

output "aks_password" {
    value = azurerm_kubernetes_cluster.aks.kube_config[0].password
    sensitive = true
}

output "aks_cluster_name" {
    value = azurerm_kubernetes_cluster.aks.name
}

output "aks_resource_group_name" {
    value = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "aks_location" {
    value = azurerm_kubernetes_cluster.aks.location
}

output "aks_host" { 
    value = azurerm_kubernetes_cluster.aks.kube_config[0].host
    sensitive = true
}

output "aks_ca_cert" { 
    value = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
    sensitive = true
}

output "aks_client_cert" { 
    value = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
    sensitive = true
}

output "aks_client_key" { 
    value = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
    sensitive = true
}