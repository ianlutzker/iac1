// az deployment sub create --location eastus --template-file main.bicep --parameters resourceGroupLocation='westus3'

targetScope = 'subscription'

param resourceGroupLocation string
param randomString string = take(uniqueString(subscription().id), 5)

module resourceGroupModule 'modules/rg.bicep' = {
  scope: subscription()
  name: 'aks${randomString}rg'
  params: {
    resourceGroupName: 'aks${randomString}rg'
    resourceGroupLocation: resourceGroupLocation
  }
}

module aksModule 'modules/aks.bicep' = {
  scope: resourceGroup(resourceGroupModule.name)
  dependsOn: [ resourceGroupModule ]
  name: 'aks'
  params: {
    clusterName: 'aks${randomString}cluster'
    location: resourceGroupModule.outputs.resourceGroupLocation
    //dnsPrefix: 'aks${randomString}cluster'
    osDiskSizeGB: 0
    agentCount: 1
    agentVMSize: 'Standard_B2als_v2'
    //linuxAdminUsername: 'azureuser'
    //sshRSAPublicKey: ''
  }
}

output controlPlaneFQDN string = aksModule.outputs.controlPlaneFQDN
