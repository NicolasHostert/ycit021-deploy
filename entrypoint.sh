#!/bin/ash
echo "NEW ENTRYPOINT"
# Getting the lastest version of the infra we need to deploy and running it.
git clone https://github.com/devops-moonwalkers/gcp-infra.git
cd gcp-infra/
cp /app/backend.tf /app/gcp-infra/backend.tf -f
cp /app/terraform.tfvars /app/gcp-infra/terraform.tfvars -f

terraform init
terraform apply -auto-approve
