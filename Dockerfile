FROM moonwalkers/terraform:202112061807
LABEL org.opencontainers.image.authors="nicolas@secretemail.com"

WORKDIR /app

# Mount secrets .
RUN --mount=type=secret,id=GCP_CREDENTIAL,dst=/app/gcp.json cat gcp.json > /app/service-account.json
RUN --mount=type=secret,id=TERRAFORM_TOKEN,dst=/app/terraformrc cat /app/terraformrc > /app/.terraformrc
RUN --mount=type=secret,id=BUCKET_PROD,dst=/app/backend.txt cat /app/backend.txt > /app/backend.tf
RUN --mount=type=secret,id=TFVARS_PROD,dst=/app/tfvars cat /app/tfvars > /app/terraform.tfvars

# Set environment variables for GCP and Terraform credentials
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/service-account.json"
ENV TF_CLI_CONFIG_FILE="/app/.terraformrc"

RUN cat /app/terraform.tfvars
RUN cat /app/backend.tf

COPY entrypoint.sh .
ENTRYPOINT ["ash","entrypoint.sh"]