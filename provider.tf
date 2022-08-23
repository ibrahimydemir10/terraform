terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.18.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "4ca364fb-7d95-4f63-8fe9-d174d2af3dec"
  tenant_id = "44ae9dcb-6ec1-4847-b246-e416c8d9a389"
  client_id = "717e40a4-cbab-4f06-b7ee-3abdd84db3d4"
  client_secret = "pdG8Q~ph2iyEhTFoN69G6X7z4634-G4845DoOanV"
  features {}
}