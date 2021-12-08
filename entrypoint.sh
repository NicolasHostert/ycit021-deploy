#!/bin/ash

# Getting the lastest version of the infra we need to deploy and running it.
git clone https://github.com/devops-moonwalkers/gcp-infra.git
cd gcp-infra/
cp /app/backend.tf . -f
cp /app/terraform.tfvars . -f

terraform init
terraform plan
terraform apply -auto-approve
