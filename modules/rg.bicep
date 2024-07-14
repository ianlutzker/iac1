targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

// output resourceGroupName string = resourceGroup.name
// output resourceGroupId string = resourceGroup.id
output resourceGroupLocation string = resourceGroup.location
output resourceGroupName string = resourceGroup.name
