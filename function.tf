resource "azurerm_storage_account" "function-sa" {
    name                     = "${var.identifier}-function-sa"
    resource_group_name      = azurerm_resource_group.res-group.name
    location                 = azurerm_resource_group.res-group.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "appserv-plan" {
    name                = "${var.identifier}-functions-service-plan"
    location            = azurerm_resource_group.res-group.location
    resource_group_name = azurerm_resource_group.res-group.name
    kind                = "FunctionApp"

    sku {
        tier = "Dynamic"
        size = "Y1"
    }
}

resource "azurerm_function_app" "function-app" {
    name                      = "${var.identifier}-sentinel-functions"
    location                  = azurerm_resource_group.res-group.location
    resource_group_name       = azurerm_resource_group.res-group.name
    app_service_plan_id       = azurerm_app_service_plan.appserv-plan.id
    storage_connection_string = azurerm_storage_account.function-sa.primary_connection_string
}