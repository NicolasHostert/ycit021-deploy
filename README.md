# YCIT021 - Deployment repository

## Objective

This repository is used to deploy the infrastructure and the application, all in one go

## Workflow: Deploy all the things

### How to deploy
To deploy the infrastructure, go to the [actions](https://github.com/NicolasHostert/ycit021-deploy/actions/workflows/main.yml), and click Run workflow.

You will get the URL of the application URL in {ENV}-application in the Check the deployed service URL step. 

### Pre-flight
In that step, we are checking that the Dockerfile is properly linted.

### Deployment steps

There are two environments:
* dev
* prod

Each of these environment gets 2 steps
* {ENV}-infra:
    * It will deploy the infrastructure
    * It is based on the Moonwalkers terraform module
    * It takes the proper credentials and configs from the project secrets

* {ENV}-application
    * The application that will be deployed can be found [there](https://github.com/NicolasHostert/nuxt-realworld).
    * The image has been build and is deployed with a Helm chart that can be found [there](https://github.com/NicolasHostert/ycit021-myapp).
    * After deploying the application, it will curl the appliction URL to determine if we get a 200 http response code or not, and fail if it's not working.

The dev environment will deploy immediatly when the workflow is run. The production one will wait for an approval.

## Secrets used by the pipeline and their formatting

DOCKERHUB_TOKEN

    <VALUE>


DOCKERHUB_USERNAME

    <VALUE>

TERRAFORM_TOKEN

    credentials ""app.terraform.io"" {
        ""token"" = "" <VALUE> ""
    }

GCP_CREDENTIAL_DEV and GCP_CREDENTIAL_PROD

    {
      ""type"": ""service_account"",
      ""project_id"": "" <VALUE> "",
      ""private_key_id"": "" <VALUE> "",
      ""private_key"": "" <VALUE on one line with \n> "",
      ""client_email"": "" <VALUE> "",
      ""client_id"": "" <VALUE> "",
      ""auth_uri"": ""https://accounts.google.com/o/oauth2/auth"",
      ""token_uri"": ""https://oauth2.googleapis.com/token"",
      ""auth_provider_x509_cert_url"": ""https://www.googleapis.com/oauth2/v1/certs"",
      ""client_x509_cert_url"": "" <VALUE> ""
    }


GCP_AUTH_DEV and GCP_AUTH_PROD

    -----BEGIN PRIVATE KEY-----
    <VALUE>
    -----END PRIVATE KEY-----

BUCKET_DEV and BUCKET_PROD

    terraform {
      backend ""gcs"" {
        bucket = "" <VALUE> ""
        prefix = ""state""
      }
    }

TFVARS_DEV and TFVARS_PROD

    gcp_project_id = "" <VALUE> ""
    gcp_region = "" <VALUE> ""


## Value Stream Mapping

![ValueStreamMapping.jpg](ValueStreamMapping.jpg)