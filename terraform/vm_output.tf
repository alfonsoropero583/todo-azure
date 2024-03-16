# La dirección IP publica de Podman-vm.
output "vm_ip" {
  value = azurerm_linux_virtual_machine.main.public_ip_address
}

# Administrador de Podman-vm.
output "vm_admin_username" {
  value = azurerm_linux_virtual_machine.main.admin_username
}

# Clave administrador de Podman-vm.
output "vm_admin_password" {
  value = azurerm_linux_virtual_machine.main.admin_password
  sensitive = true
}

# Clave privada del usuario administrador de Podman-vm.
output "vm_admin_private_key" {
  value = tls_private_key.admin_private_key.private_key_pem
  sensitive = true
}