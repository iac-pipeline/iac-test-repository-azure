resource "azurerm_resource_group" "teststore" {
  name     = "test-storage-account-${var.env_prefix}"
  location = "northeurope"
}

resource "azurerm_storage_account" "teststore" {
  name                     = "teststoreageaccount${var.env_prefix}"
  resource_group_name      = azurerm_resource_group.teststore.name
  location                 = azurerm_resource_group.teststore.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "teststore" {
  name                  = "test-storage-container-${var.env_prefix}"
  storage_account_id    = azurerm_storage_account.teststore.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "teststore" {
  name                   = "${var.env_prefix}.txt"
  storage_account_name   = azurerm_storage_account.teststore.name
  storage_container_name = azurerm_storage_container.teststore.name
  type                   = "Block"
  source                 = "test.txt"
}