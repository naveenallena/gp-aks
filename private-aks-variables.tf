#### locals
variable "resource_group_name" {
  type    = string
  #default = "my-resource-group"
}

variable "resource_group_location" {
  type    = string
  default = "eastus"
}

## Existing subnet for pods & Node ip's.
variable "subnet_name" {
  type    = string
}

variable "vnet_name" {
  type    = string
}

# Existing user assigned identity for both kubenet and control plane

variable "uai_name" {
  type    = string
}

## AKS Cluster

variable "aks_cluster_name" {
  type  = string
}

variable "aks_sku_tier"{
type = string
}

variable "kubernetes_version"{
type = string
}

variable "dns_prefix" {
type = string
}

variable "node_resource_group_name" {
type    = string
}

variable "private_dns_zone_id" {
type = string
}

## AKS Network Profile

variable "network_plugin"{
type = string
}

variable "network_policy"{
type = string
}

variable "outbound_type"{
type = string
}

variable "service_cidr"{
type = string
}

variable "dns_service_ip"{
type = string
}

## node pool

variable "node_pool_name"{
type = string
}

variable "vm_size"{
type = string
}

variable "nodepool_zones_availability"{
type = list
}

variable "node_count"{
type = string
}

### tags

variable "tags" {
  type = map(string)
  default = {}
  }