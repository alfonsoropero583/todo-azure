#!/bin/bash

# Exportar las variables de salida de Terraform
export VM_ADMIN_USERNAME=$(terraform output -raw vm_admin_username)
export VM_ADMIN_PASSWORD=$(terraform output -raw vm_admin_password)
export VM_IP=$(terraform output -raw vm_ip)

export ACR_ADMIN_USERNAME=$(terraform output -raw acr_admin_username)
export ACR_ADMIN_PASSWORD=$(terraform output -raw acr_admin_password)
export ACR_SERVER=$(terraform output -raw acr_login_server)

export AKS_KUBE_CONFIG=$(terraform output -raw aks_kube_config)

# Adiccionales
export AKS_HOST=$(terraform output -raw aks_host)
export AKS_CA_CERT=$(terraform output -raw aks_ca_cert)
export AKS_CA_CLIENT_CERT=$(terraform output -raw aks_client_cert)
export AKS_CA_CLIENT_KEY=$(terraform output -raw aks_client_key)
export AKS_CLUSTER_NAME=$(terraform output -raw aks_cluster_name)
export AKS_LOCATION=$(terraform output -raw aks_location)
export AKS_PASSWORD=$(terraform output -raw aks_password)
export AKS_USERNAME=$(terraform output -raw aks_username)
export AKS_RESOURCE_GROUP_NAME=$(terraform output -raw aks_resource_group_name)

# Copiar la clave pública al servidor remoto 
sshpass -p $VM_ADMIN_PASSWORD ssh-copy-id -i ~/.ssh/id_rsa.pub $VM_ADMIN_USERNAME@$VM_IP