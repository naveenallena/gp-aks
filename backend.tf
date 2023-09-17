/*
terraform {
  backend "azurerm" {
    resource_group_name  = "labs-oossayenko-use-RG"
    storage_account_name = "labsterraformstate"
    container_name       = "terraformstate"
    key                  = "private-aks-test.tfstate"
  }
}
*/
provider "azurerm" {
  #version = "~> 2.22.0"
  features {}
}
