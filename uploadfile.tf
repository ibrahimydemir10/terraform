/*
resource "azurerm_storage_blob" "files" {
    for_each = {
        sample1 = "C:\\Users\\iaydemir\\Documents\\learning-terraform\\files\\tmp1"
        sample2 = "C:\\Users\\iaydemir\\Documents\\learning-terraform\\files\\tmp2"
        sample3 = "C:\\Users\\iaydemir\\Documents\\learning-terraform\\files\\tmp3"
        

    }
    name = "${each.key}.txt"
    storage_account_name = "1storageaccount45654342"
    storage_container_name = "data"
    type = "Block"
    source = each.value
    depends_on = [
         azurerm_storage_container.data
    ]
}
*/