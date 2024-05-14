#!/bin/sh

set -e

# Initialize Terraform
echo "Initializing Terraform..."
terraform init -input=false

# Check if the first command line argument is "destroy"
if [ "$1" = "destroy" ]; then
    echo "Planning destruction..."
    terraform plan -destroy -out=tfdestroyplan -state=/app/.state/terraform.tfstate

    echo "Applying destruction..."
    terraform apply -auto-approve "tfdestroyplan"
else
    echo "Planning apply..."
    terraform plan -out=tfplan -state=/app/.state/terraform.tfstate

    echo "Applying plan..."
    terraform apply -auto-approve "tfplan"
fi