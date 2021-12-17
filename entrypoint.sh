#!/bin/ash

# Getting the lastest version of the infra we need to deploy and running it.
git clone https://github.com/NicolasHostert/ycit021-terraform.git
cd ycit021-terraform/
cp /app/backend.tf /app/ycit021-terraform/backend.tf -f
cp /app/terraform.tfvars /app/ycit021-terraform/terraform.tfvars -f

terraform init
terraform apply -auto-approve
