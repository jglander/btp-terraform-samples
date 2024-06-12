###############################################################################################
# Setup subaccount domain and the CF org (to ensure uniqueness in BTP global account)
###############################################################################################
locals {
  random_uuid = uuid()
  project_subaccount_domain = "my-sa-${local.random_uuid}"
  project_subaccount_cf_org = substr(replace("${local.project_subaccount_domain}", "-", ""),0,32)
  custom_idp = var.custom_ias_tenant != "" ? "${var.custom_ias_tenant}.accounts400.ondemand.com" : ""
}

###############################################################################################
# Create subaccount
###############################################################################################
resource "btp_subaccount" "project" {
  name      = var.subaccount_name
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
  usage = "USED_FOR_PRODUCTION"
}

######################################################################
# Get all available environments for the subaccount
######################################################################
data "btp_subaccount_environments" "all" {
  subaccount_id = btp_subaccount.project.id
}

######################################################################
# Extract list of CF landscape labels from environments
######################################################################
locals {
  cf_landscape_labels = [
    for env in data.btp_subaccount_environments.all.values : env.landscape_label
    if env.environment_type == "cloudfoundry"
  ]
}

######################################################################
# Create Cloud Foundry environment
######################################################################
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = btp_subaccount.project.id
  name             = "my-cf-environment"
  # pick the first CF landscape label
  landscape_label  = local.cf_landscape_labels[0]
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "standard"
  parameters = jsonencode({
    instance_name = local.project_subaccount_cf_org
  })
}