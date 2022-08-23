
data "azurerm_key_vault" "appkey235012" {
  name                = "appkey235012"
  resource_group_name = "new-rgrp"
}

data "azurerm_key_vault_secret" "password" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.appkey235012.id
}
