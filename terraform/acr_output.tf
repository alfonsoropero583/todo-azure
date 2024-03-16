# El servidor de inicio de sesión del registro de contenedores de Azure.
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

# El nombre de usuario administrador del registro de contenedores de Azure.
output "acr_admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

# La contraseña del usuario administrador del registro de contenedores de Azure.
output "acr_admin_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}