---
title: Configure Azure Service Principal
linktitle: AKS Service Principal
type: docs
weight: 100
aliases:
---

Azure has a notion of a **Service Principal** which, in simple terms, is a service acount. This doc will demonstrate how to set up an Azure service principal that can be used by Terraform to execute [Jenkins X Azure Module](https://github.com/jenkins-x/terraform-azurerm-jx#jenkins-x-azure-module)

> ⚠️  This doc has been designed to assist in performing the demonstration through copying and pasting each block of code into a shell terminal and using the Azure portal.<br>
>
> To execute the commands listed in your local bash shell will require the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) and the [JQ command-line JSON processor](https://stedolan.github.io/jq/).<br>
>
> To execute the commands listed in [Bash in Azure Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview) does not require any additional software installed.

### Service principal privileges
In order to build your Azure environment with Terraform using a service principal, the following are the minimal requirements:
* Subscription built-in roles;`Contributor`and`User Access Administator`.
* Active Directory built-in application admin role;`Cloud Application Administrator`.
* Active Directory Graph API permission;`Application.ReadWrite.All`.

Further details can be found under [Jenkins X Azure Module Prequisites](https://github.com/jenkins-x/terraform-azurerm-jx#prerequisites)
### Create service principal with subscription roles
The first step is to create a new service principal (APP_NAME) and to assign it the subscription built-in roles `Contributor` and `Cloud Application Administrator`.
> ⚠️  If you are using a local terminal, prior to executing the following commands, in the local terminal log into Azure (`az login`) with an ID that has the necessary privileges (i.e. Owner). 
> Always perform all commands in the same local terminal session to preserve dependent variables that are created.
>
> If you are using Bash in Azure cloud shell, there is no need to login (`az account show`). Once again take caution not to lose the bash session in the portal web page.
```bash
read -p "Service Principal (i.e. mySvcPr) : " APP_NAME
```
```bash
SUBSCRIPTION_ID=$(az account show --query id --output tsv)
SVCP=$(az ad sp create-for-rbac --role Contributor --name $APP_NAME --scopes /subscriptions/$SUBSCRIPTION_ID --output json --only-show-errors)
APP_ID=$(echo $SVCP | jq -r .appId)
OBJ_ID=$(az ad sp list --filter "appId eq '$APP_ID'" --output json | jq '.[0].objectId' -r)
PASS_ID=$(echo $SVCP | jq -r .password)
TENANT_ID=$(echo $SVCP | jq -r .tenant)
az role assignment create --role "User Access Administrator" --assignee-object-id $OBJ_ID --only-show-errors
```
Use the following command to check the service principal subscription role settings.
``` bash 
az role assignment list --assignee $APP_ID --query [].roleDefinitionName --output json --only-show-errors
```
You should see the following:
```
[
  "User Access Administrator",
  "Contributor"
]
```
### Assign service principal admin role using portal
The second step will be to assign the new service principal the `Cloud Application Administrator` application admin role using the Azure portal. 
> ⚠️  If you are using a local terminal session, [Click here](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RolesAndAdministrators) to position to **SCREEN 1**<br>
>
> If you are using Bash in Azure Cloud Shell session, to avoid potentially losing the session  in the portal window with the terminal navigate to **SCREEN 1**.

- SCREEN 1: Azure Active Directory | Overview | Roles and administrators<br>
	___ Search for “Cloud application administrator” then click on the role.

![roles admin section](/images/v3/roles_and_admin.png)

- SCREEN 2:  Cloud application administrator | Assignments<br>
	___ Click on + Add assignments<br>
	___ In the 'Add assignments' dialog search for the service principal ($APP_NAME)<br>
	___ Select ther service princiapl ($APP_NAME) and click the 'Add' button.

![cloud app admin section](/images/v3/cloud_app_admin.png)
To validate that the assignment was made, while stll on SCREEN 2 click on `Assignments`on the left navigation. You should see the service principal included in the list.
### Assign service principal graph API permission
THe third step is to assign Active Directory Graph API permission `Application.ReadWrite.All`.
> ⚠️  This application is using Azure AD Graph API, which is on a deprecation path. As of June 30th, 2020 there were no longer any new features added to the Azure AD Graph API.
```bash
# Azure Active Directory Graph
API_ID=00000002-0000-0000-c000-000000000000
APPLICATION_READWRITE_ALL_ID=$(az ad sp show --id $API_ID --query "appRoles[?value=='Application.ReadWrite.All'].id" --output tsv)
az ad app permission add --id $APP_ID --api $API_ID --api-permissions $APPLICATION_READWRITE_ALL_ID=Role --only-show-errors
az ad app permission grant --id $APP_ID --api $API_ID --only-show-errors
APP_OBJECT_ID=$(az ad sp show --id $APP_ID --query "objectId" --output tsv)
API_OBJECT_ID=$(az ad sp show --id $API_ID --query "objectId" --output tsv)
az rest --method POST --uri "https://graph.microsoft.com/v1.0/servicePrincipals/$APP_OBJECT_ID/appRoleAssignments" --headers '{"Content-Type": "application/json"}' --body "{\"principalId\": \"$APP_OBJECT_ID\", \"resourceId\": \"$API_OBJECT_ID\", \"appRoleId\": \"$APPLICATION_READWRITE_ALL_ID\"}" --only-show-errors
```
Use the following command to check the service principal API settings.
``` bash
az ad app permission list --id $APP_ID --only-show-errors --output table
```
You should see something like the following:
```
ExpiryTime                  ResourceAppId
--------------------------  ------------------------------------
2022-12-20T00:21:52.224478  00000002-0000-0000-c000-000000000000
```

### Prepare to run Terraform
Once the service prinicpa is created and assigned the appropriate roles and permissions, it can now be used by Terraform to execute the Jenkins X Azure module. In order for Terraform to use the service principal credentials you need to [specify service principal credentials in environment variables](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash)
```
export ARM_CLIENT_ID=${APP_ID}
export ARM_CLIENT_SECRET=${PASS_ID}
export ARM_TENANT_ID=${TENANT_ID}
export ARM_SUBSCRIPTION_ID=${SUBSCRIPTION_ID}
```
The following Azure CLI commands will display the role assignment list, app permissions list , and a portal URL for the service principal. It will also export the necessary ARM_ variables required for Terraform credentials.
``` bash 
echo $APP_NAME
echo $SVCP
az role assignment list --assignee $APP_ID --query [].roleDefinitionName --output json --only-show-errors
az ad app permission list --id $APP_ID --only-show-errors
echo "Check Service Principal at:"
echo " https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Overview/appId/$APP_ID"
eval export ARM_CLIENT_ID=$APP_ID
eval export ARM_CLIENT_SECRET=$PASS_ID
eval export ARM_TENANT_ID=$TENANT_ID
eval export ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID
env | grep ARM_
```
At this point you should now be ready to perform the Terraform steps to build the environment using the service principal credentials. You should keep the Terraform environment variables (ARM_) values in a safe place unitl the service principal resource is deleted. You can find more details on managing the service principal by viewing [Create an Azure service principal with the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli#reset-credentials).
### Clean up
Clean up is straightforward. Once you delete the service principal all roles and permissopms are also deleted as well.  The following Azure CLI commands will remove the roles and service principal.
``` bash
az ad sp delete --id $APP_ID --only-show-errors
```
In the above command you also can use `$ARM_CLIENT_ID` which is the same value as `$APP_ID` to delete the resource.
```
