#local vars

locals {
  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
 }

#Existing subnet with address space "10.0.1.0/25

data "azurerm_subnet" "base" {
  name                = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name = "devtest-data-use-RG"
}
# Existing user assigned identity

data "azurerm_user_assigned_identity" "base" {
  name                = var.uai_name
  resource_group_name = local.resource_group_name
}

# Existing Private DNS zone
/*
data "azurerm_dns_zone" "base" {
  name                = ["private.eastus.azmk8s.io"]
  resource_group_name = "labs-vredlapalli-test-rg"
  #id                  = data.azurerm_dns_zone.base.id
}
*/

#kubernetes_cluster

resource "azurerm_kubernetes_cluster" "base" {
  name                    = var.aks_cluster_name
  location                = local.resource_group_location
  resource_group_name     = local.resource_group_name
  node_resource_group     = var.node_resource_group_name
  sku_tier                = var.aks_sku_tier
  kubernetes_version      = var.kubernetes_version
  dns_prefix              = var.dns_prefix 
  private_cluster_enabled = true
  ## Azure RBAC Enable
 #azure_rbac_enabled     = true

  #private_dns_zone_id    = data.azurerm_dns_zone.base.id
  private_dns_zone_id     = var.private_dns_zone_id
  tags                    = var.tags

azure_active_directory_role_based_access_control {
#admin_group_object_ids = ["8463f85a-31e5-48e8-9b96-a3b96f28bf0a"]
azure_rbac_enabled     = true
managed                = true
#tenant_id              = "11e55079-15ef-4cd4-b82c-e8739df53616"
}

  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    outbound_type  = var.outbound_type
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
    load_balancer_profile {
      
     #effective_outbound_ips      = ["20.88.163.20"]
      outbound_ip_address_ids  = ["/subscriptions/9d9e15b7-b540-4fc0-b7fd-581b495962fc/resourceGroups/devtest-k8s-use-RG/providers/Microsoft.Network/publicIPAddresses/public-dev-k8s-outbound-use-PIP"]
      
    }
 }
    
  default_node_pool {
    name           = var.node_pool_name
    vm_size        = var.vm_size
    vnet_subnet_id = data.azurerm_subnet.base.id
    zones          = var.nodepool_zones_availability
    node_count     = var.node_count
  # max_count     = 1
  # min_count     = 1

  }
   #auto_scaler_profile {
  #}

  identity {
    type           = "UserAssigned"
    # identity_ids = [azurerm_user_assigned_identity.base.id]
    identity_ids   = [data.azurerm_user_assigned_identity.base.id]
  }

    kubelet_identity {
    client_id = data.azurerm_user_assigned_identity.base.client_id
    object_id = data.azurerm_user_assigned_identity.base.principal_id
    user_assigned_identity_id = data.azurerm_user_assigned_identity.base.id
  }
}