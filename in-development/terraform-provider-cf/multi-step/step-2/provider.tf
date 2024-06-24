terraform {
  required_providers {
    cloudfoundry = {
      source  = "SAP/cloudfoundry"
      version = "0.2.1-beta"
    }
  }
}

locals {
  cf_origin = var.custom_ias_tenant != "" ? "${var.custom_ias_tenant}-platform" : "sap.default"
}

######################################################################
# Configure CF provider
######################################################################
provider "cloudfoundry" {
    # resolve API URL from environment instance
    api_url = var.cf_api_url
    origin = local.cf_origin
}