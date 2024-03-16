# Recurso para la creación de una red virtual en Azure.
resource "azurerm_virtual_network" "main" {
  name                = "podman-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Recurso para la creación de una subred interna en Azure.
resource "azurerm_subnet" "piip" {
  name                 = "podman-piip"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Recurso para la creación de una IP pública en Azure.
resource "azurerm_public_ip" "puip" {
  name                = "podman-puip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

# Recurso para la creación de una interfaz de red en Azure.
resource "azurerm_network_interface" "main" {
  name                = "podman-nic1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.piip.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.puip.id
  }
}

# Recurso para la creación de una interfaz de red interna en Azure.
resource "azurerm_network_interface" "piip" {
  name                = "podman-nic2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "piip"
    subnet_id                     = azurerm_subnet.piip.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Recurso para la creación de un grupo de seguridad de red en Azure.
resource "azurerm_network_security_group" "ans" {
  name                = "podman-ans"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "tls"
    priority                   = 100
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = "*"
  }

  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "http"
    priority                   = 200
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = "*"
  }
}

# Recurso para asociar una interfaz de red a un grupo de seguridad de red en Azure.
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.piip.id
  network_security_group_id = azurerm_network_security_group.ans.id
}

# Recurso para la generación de una clave privada TLS.
# No me funciono, así que tuve que volver a la clave local. Dejo la petición para analizarla más adelante.
resource "tls_private_key" "admin_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generar una contraseña aleatoria para el administrador
resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Recurso para la creación de una máquina virtual Ubuntu en Azure.
resource "azurerm_linux_virtual_machine" "main" {
  name                            = "podman-vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1ls"
  admin_username                  = "adminazure"
  admin_password = random_password.admin_password.result
  disable_password_authentication = false

# No me funciono, así que tuve que volver a la clave local. Dejo la petición para analizarla más adelante.
  admin_ssh_key {
    username   = "adminazure"
    public_key = tls_private_key.admin_private_key.public_key_openssh
  }

  network_interface_ids = [
    azurerm_network_interface.main.id,
    azurerm_network_interface.piip.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}