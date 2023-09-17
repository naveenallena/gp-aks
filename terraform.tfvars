## locals
resource_group_name = "devtest-k8s-use-RG"
resource_group_location = "eastus"

## Existing subnet for pods & Node ip's.

subnet_name = "devtest-dev-k8s-use-SNET"
vnet_name = "devtest-use-VNET"

# Existing user assigned identity for both kubenet and control plane

uai_name="dev-k8s-use-MI"

### AKS Cluster
aks_cluster_name= "devtest-dev-k8s-use-AKS"
node_resource_group_name = "dev-cluster-k8s-use-RG"
aks_sku_tier ="Standard"
kubernetes_version = "1.25"
dns_prefix = "dev"
private_dns_zone_id = "/subscriptions/58d3b1f5-af8f-4621-b816-c003ef862587/resourceGroups/prod-dns-use-RG/providers/Microsoft.Network/privateDnsZones/privatelink.eastus.azmk8s.io"

## AKS Network Profile

network_plugin = "azure"
network_policy = "azure"
outbound_type = "loadBalancer"
service_cidr = "10.2.0.0/24"
dns_service_ip = "10.2.0.19"

#Node pool

node_pool_name = "nodesk8s"
vm_size = "Standard_D2_v2"
nodepool_zones_availability = [1,2,3]
node_count = 3

## tags

tags = {
  "env"        = "dev"
  "created_by" = "vredlapalli"
  "owner"      = "rginsberg"
  
}