terraform {
  backend "azurerm" {
    resource_group_name  = "my-resource-group"
    storage_account_name = "storagexc"
    container_name       = "xc-blob"
    key                  = "terraform.tfstate" 
  }
}
