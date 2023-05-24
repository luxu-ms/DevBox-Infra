# DevBox-Infra
This repo is to help quickly set up the Dev Box service including Dev Center, Dev box Project, Dev box Definition, Dev box pool, Network connection and Virtual Netowrk.

>Note1: If you want to use your existing subnet id, please provide your subnet resource id in the "Existing Subnet Id". Thus no new virtual network and subnet will be created. The subnet id is like this format: /subscriptions/{subscription id}/resourceGroups/{resource group name}/providers/Microsoft.Network/virtualNetworks/{virtual network name}/subnets/{subnet name}

>Note2: If you want to grant the role "DevCenter Dev Box User" to your user at Dev box project level, please provide the principal id in the "Principal Id". If principal type is "User", you can find the principal id as object id in the AAD's user. If principal type is "Group", you can find the principal id as object id in the AAD's group.

[![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fluxu-ms%2FDevBox-Infra%2Fmain%2Fazuredeploy.json)
