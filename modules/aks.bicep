param tags object

@description('The name of the Managed Cluster resource.')
param clusterName string

@description('The location of the Managed Cluster resource.')
param location string

// @description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
// param dnsPrefix string

param agentPoolName string

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int

@description('The size of the Virtual Machine.')
param agentVMSize string

// @description('User name for the Linux Virtual Machines.')
// param linuxAdminUsername string

// @description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
// param sshRSAPublicKey string

resource aks 'Microsoft.ContainerService/managedClusters@2024-02-01' = {
  name: clusterName
  location: location
  tags: tags
  sku: {
    name: 'Base'
    tier: 'Free'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: clusterName
    // enableRBAC: true
    disableLocalAccounts: false

    // aadProfile: {
    //   enableAzureRBAC: true
    //   managed: true
    // }
    
    storageProfile: {
      blobCSIDriver: {
        enabled: true
      }
      diskCSIDriver: {
        enabled: true
      }
      fileCSIDriver: {
        enabled: true
      }
    }
    
    networkProfile: {
      networkPlugin: 'kubenet' // 'azure'
      //loadBalancerSku: 'standard'
      outboundType: 'managedNATGateway'
      // networkMode: 'bridge'
      // networkPluginMode: 'overlay'
      // networkPolicy: 'calico'
    }

    agentPoolProfiles: [
      {
        name: agentPoolName
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
        
      }
    ]
    // linuxProfile: {
    //   adminUsername: linuxAdminUsername
    //   ssh: {
    //     publicKeys: [
    //       {
    //         keyData: sshRSAPublicKey
    //       }
    //     ]
    //   }
    // }
  }
}

output controlPlaneFQDN string = aks.properties.fqdn
