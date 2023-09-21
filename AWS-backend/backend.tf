terraform {
  backend "azurerm" {
    resource_group_name  = "myresource-group"
    storage_account_name = "storagexc"
    container_name       = "xc-blob"
    key                  = "aws-terraform.tfstate" # Global Networking
  }
}
