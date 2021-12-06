FROM moonwalkers/terraform:202112061807
LABEL org.opencontainers.image.authors="nicolas@secretemail.com"

WORKDIR /app

# Mount secrets .
RUN --mount=type=secret,id=GCP_CREDENTIAL,dst=/app/gcp.json cat gcp.json > /app/service-account.json
RUN --mount=type=secret,id=TERRAFORM_TOKEN,dst=/app/terraformrc cat /app/terraformrc > /app/.terraformrc

# Set environment variables for GCP and Terraform credentials
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/service-account.json"
ENV TF_CLI_CONFIG_FILE="/app/.terraformrc"

ENTRYPOINT ["ash","entrypoint.sh"]