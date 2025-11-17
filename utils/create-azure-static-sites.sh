#!/bin/bash
# Script to create Azure resource group and static web apps for dev, test, and prod

set -e

RESOURCE_GROUP="github-env-demo-rg"
LOCATION="australiaeast"

# Create resource group
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

# Create static web apps
for ENV in dev test prod; do
  az staticwebapp create \
    --name "github-env-demo-$ENV" \
    --resource-group "$RESOURCE_GROUP" \
    --location "eastasia" \
    --sku Free
  echo "Created static web app: github-env-demo-$ENV"

  # Get and print the deployment token
  echo "Deployment token for github-env-demo-$ENV:"
  az staticwebapp secrets list --name "github-env-demo-$ENV" --resource-group "$RESOURCE_GROUP" --query "properties.apiKey" -o tsv
done

echo "All resources created."
echo ""
echo "To deploy from GitHub Actions, you need the Azure Static Web Apps API token."
echo "Get it from the Azure Portal:"
echo "1. Go to your Static Web App in the Azure Portal."
echo "2. In the left menu, select 'Manage deployment token'."
echo "3. Copy the token and add it as the secret AZURE_STATIC_WEB_APPS_API_TOKEN in your GitHub repository settings."

