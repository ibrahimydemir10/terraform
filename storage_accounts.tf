/*

resource "azurerm_storage_account" "storageaccount45654342" {
  count = 3
  name                     = "${count.index}storageaccount45654342"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [
    azurerm_resource_group.for_test_purposes
  ]

}

resource "azurerm_storage_container" "data" {
  for_each = toset(["data","files","documents"])
  name                  = each.key
  storage_account_name  = "1storageaccount45654342"
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.storageaccount45654342
  ]
}
*/
