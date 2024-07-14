// az deployment sub create --location westus3 --template-file main.bicep

targetScope = 'subscription'

param resourceGroupLocation string = 'westus3'
param randomString string = take(uniqueString(subscription().id), 5)

module resourceGroupModule 'modules/rg.bicep' = {
  scope: subscription()
  name: 'resourceGroupDeployment'
  params: {
    resourceGroupName: 'aks-${randomString}-rg'
    resourceGroupLocation: resourceGroupLocation
  }
}

module aksModule 'modules/aks.bicep' = {
  scope: resourceGroup(resourceGroupModule.name)
  dependsOn: [ resourceGroupModule ]
  name: 'aksDeployment'
  params: {
    tags: resourceGroupModule.outputs.resourceGroupTags
    clusterName: 'aks-${randomString}-cluster'
    location: resourceGroupModule.outputs.resourceGroupLocation
    //dnsPrefix: 'aks${randomString}cluster'
    agentPoolName: 'agentpool1'
    osDiskSizeGB: 0
    agentCount: 1
    agentVMSize: 'Standard_B2als_v2'
    //linuxAdminUsername: 'azureuser'
    //sshRSAPublicKey: ''
  }
}

output controlPlaneFQDN string = aksModule.outputs.controlPlaneFQDN
