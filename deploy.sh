az login
az account list
az account show --query id --output tsv
az account set --subscription "Azure for Students"   # Change this one

az group list

az group list --query [].name --output table
# ShortCut gives errors from 2023-11-17
# az webapp up --runtime PYTHON:3.9 --sku B1 --logs


# Long way home
LOCATION='westeurope'
RESOURCE_GROUP_NAME='esra.shawkat_rg_7810'  # Could change

# Create a resource group
az group create \
    --location $LOCATION \
    --name $RESOURCE_GROUP_NAME

APP_SERVICE_PLAN_NAME='esra.shawkat_asp_4613'    

az appservice plan create \
    --name $APP_SERVICE_PLAN_NAME \
    --resource-group $RESOURCE_GROUP_NAME \
    --is-linux

# Change 123 to any three characters to form a unique name across Azure
APP_SERVICE_NAME='salmon-sky-611700db7dd4475aac2c11cd4d30fedd'  # Could change

az webapp create\
    --name $APP_SERVICE_NAME \
    --plan $APP_SERVICE_PLAN_NAME\
    --runtime 'PYTHON:3.9' \
    --resource-group $RESOURCE_GROUP_NAME \
    --query 'defaultHostName' \
    --output table


az webapp up\
    --name $APP_SERVICE_NAME \
    --plan $APP_SERVICE_PLAN_NAME\
    --runtime 'PYTHON:3.9' \
    --resource-group $RESOURCE_GROUP_NAME \
    --query 'defaultHostName' \
    --output table