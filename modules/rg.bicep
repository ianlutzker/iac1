targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
  tags: {
    Owner: 'github.com/ianlutzker'
    Environment: 'Training'
  }
}

// output resourceGroupName string = resourceGroup.name
// output resourceGroupId string = resourceGroup.id
output resourceGroupLocation string = resourceGroup.location
output resourceGroupName string = resourceGroup.name
output resourceGroupTags object = resourceGroup.tags
