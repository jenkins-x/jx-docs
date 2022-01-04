---
title: Configure Azure Service Principal
linktitle: AKS Service Principal
type: docs
weight: 100
aliases:
---

This guide will describe how to set up an Azure service principal that can be used by Terraform to maintain a AKS cluster environment using the Azure Command-Line Interface (CLI). 

### Privileges
Based upon the documentation https://github.com/jenkins-x/terraform-azurerm-jx#prerequisites the following are the minimal requirements for Terraform to execute:
* Subscription built-in roles;`Contributor`and`User Access Administator`.
* Active Directory built-in application admin role;`Cloud Application Administrator`.
* Active Directory Graph API permission;`Application.ReadWrite.All`.
### CLI Build Subscription Roles
CLI commands to create a new service principal ($APP_NAME) and to assign subscription built-in roles `Contributor` and `Cloud Application Administrator`.
```bash
read -p "Service Principal : " APP_NAME
```
```bash
echo $APP_NAME
SUBSCRIPTION_ID=$(az account show --query id --output tsv)
SVCP=$(az ad sp create-for-rbac --role Contributor --name $APP_NAME --scopes /subscriptions/$SUBSCRIPTION_ID --output json)
echo $SVCP
APP_ID=$(echo $SVCP | jq -r .appId)
OBJ_ID=$(az ad sp list --filter "appId eq '$APP_ID'" --output json | jq '.[0].objectId' -r)
USER_ID=$(echo $SVCP | jq -r .name)
PASS_ID=$(echo $SVCP | jq -r .password)
TENANT_ID=$(echo $SVCP | jq -r .tenant)
az role assignment create --role "User Access Administrator" --assignee-object-id $OBJ_ID
az role assignment list --assignee $APP_ID --query [].roleDefinitionName --output json
# The following variables need to be set for Terraform
export ARM_CLIENT_ID=$USER_ID
export ARM_CLIENT_SECRET=$PASS_ID
export ARM_TENANT_ID=$TENANT_ID
```
### Set App Admin Role with portal
Use the following steps under the portal to set the Cloud Application Administrator admin role.

- SCREEN: Azure Active Directory | Overview | Roles and administrators
	[https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RolesAndAdministrators](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RolesAndAdministrators)<br>
	___ Search for “Cloud application administrator” then click on the role.

- SCREEN: Cloud application administrator | Assignments<br>
	___ Click on + Add assignments<br>
	___ In the 'Add assignments' dialog search for the service principal ($APP_NAME)<br>
	___ Select ther service princiapl ($APP_NAME) and click the 'Add' button.
### CLI Assign Graph API permission
CLI commands to assign Active Directory Graph API permsion `Application.ReadWrite.All`.
```bash
# Azure Active Directory Graph
API_ID=00000002-0000-0000-c000-000000000000
APPLICATION_READWRITE_ALL_ID=$(az ad sp show --id $API_ID --query "appRoles[?value=='Application.ReadWrite.All'].id" --output tsv)
az ad app permission add --id $APP_ID --api $API_ID --api-permissions $APPLICATION_READWRITE_ALL_ID=Role
az ad app permission grant --id $APP_ID -—api $API_ID
APP_OBJECT_ID=$(az ad sp show --id $APP_ID --query "objectId" --output tsv)
API_OBJECT_ID=$(az ad sp show --id $API_ID --query "objectId" --output tsv)
az rest --method POST --uri "https://graph.microsoft.com/v1.0/servicePrincipals/$APP_OBJECT_ID/appRoleAssignments" --headers '{"Content-Type": "application/json"}' --body "{\"principalId\": \"$APP_OBJECT_ID\", \"resourceId\": \"$API_OBJECT_ID\", \"appRoleId\": \"$APPLICATION_READWRITE_ALL_ID\"}" --only-show-errors
az ad app permission list --id $APP_ID
echo "Check SP at: https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Overview/appId/$APP_ID"
```
### Clean Up
The following Azure CLI commands will remove the roles and service principal.
``` bash
az ad sp delete --id $APP_ID
```
