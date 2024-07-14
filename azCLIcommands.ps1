$clusterName = 'absolute-donkey-aks'
$rgName = 'absolute-donkey-rg'

# Show available upgrades for an AKS cluster
az aks get-upgrades --resource-group $rgName --name $clusterName --output table
# Upgrade an AKS cluster
az aks upgrade --resource-group $rgName --name $clusterName --kubernetes-version 1.27.9 --control-plane-only
# Upgrade an AKS cluster (Control Plane Only)
az aks upgrade --resource-group $rgName --name $clusterName --kubernetes-version 1.27.9 --control-plane-only
# List all the addons in an AKS cluster
az aks addon list --resource-group $rgName --name $clusterName --output table
# Enable an addon in an AKS cluster
az aks update --enable-blob-driver --name $clusterName --resource-group $rgName
# Show cluster properties
az aks show --name $clusterName --resource-group $rgName
# Start an AKS cluster
az aks start --name $clusterName --resource-group $rgName
# Stop an AKS cluster
az aks stop --name $clusterName --resource-group $rgName