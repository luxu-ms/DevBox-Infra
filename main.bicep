@description('The name of Dev Center')
param devcenterName string = ''

@description('The name of Network Connection')
param networkConnectionName string = ''

@description('The name of Dev Center project')
param projectName string = ''

@description('The subnet resource id if the user wants to use existing subnet')
param existingSubnetId string = ''

@description('The name of the Virtual Network')
param vnetName string = ''

@description('the subnet name of Dev Box')
param subnetName string = 'default'

@description('The vnet address prefixes of Dev Box')
param vnetAddressPrefixes string = '10.4.0.0/16'

@description('The subnet address prefixes of Dev Box')
param subnetAddressPrefixes string = '10.4.0.0/24'

@description('The user or group id that will be granted to Devcenter Dev Box User role ')
param principalId string = ''

@description('The type of principal id: User, Group or ServicePrincipal')
param principalType string = 'User'

param location string = resourceGroup().location
param resourceToken string = toLower(uniqueString(resourceGroup().id, location))
param tags object = {}

var abbrs = loadJsonContent('./abbreviations.json')
var ncName = !empty(networkConnectionName) ? networkConnectionName : '${abbrs.networkConnections}${resourceToken}'

module vnet 'core/vnet.bicep' = if(empty(existingSubnetId)) {
  name: 'vnet'
  params: {
    location: location
    tags: tags
    vnetAddressPrefixes: vnetAddressPrefixes
    vnetName: !empty(vnetName) ? vnetName : '${abbrs.networkVirtualNetworks}${resourceToken}'
    subnetAddressPrefixes: subnetAddressPrefixes
    subnetName: !empty(subnetName) ? subnetName : '${abbrs.networkVirtualNetworksSubnets}${resourceToken}'
  }
}

module devcenter 'core/devcenter.bicep' = {
  name: 'devcenter'
  params: {
    location: location
    tags: tags
    devcenterName: !empty(devcenterName) ? devcenterName : '${abbrs.devcenter}${resourceToken}'
    subnetId: !empty(existingSubnetId) ? existingSubnetId : vnet.outputs.subnetId
    networkConnectionName: ncName
    projectName: !empty(projectName) ? projectName : '${abbrs.devcenterProject}${resourceToken}'
    userIdentityName: '${abbrs.managedIdentityUserAssignedIdentities}${resourceToken}'
    networkingResourceGroupName: '${abbrs.devcenterNetworkingResourceGroup}${ncName}-${location}'
    principalId: principalId
    principalType: principalType
  }
}

output vnetName string = empty(existingSubnetId) ? vnet.outputs.vnetName : ''
output subnetName string = empty(existingSubnetId) ? vnet.outputs.subnetName : ''

output devcetnerName string = devcenter.name
output projectName string = devcenter.outputs.projectName
output networkConnectionName string = devcenter.outputs.networkConnectionName
output definitions array = devcenter.outputs.definitions
output pools array = devcenter.outputs.poolNames
