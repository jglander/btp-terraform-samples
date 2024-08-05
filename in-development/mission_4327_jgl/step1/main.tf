locals {
  random_uuid = uuid()
  project_subaccount_domain = "my-sa-${local.random_uuid}"
  project_subaccount_cf_org = substr(replace("${local.project_subaccount_domain}", "-", ""),0,32)
}

###############################################################################################
# Generating random ID for subdomain
###############################################################################################
#resource "random_uuid" "uuid" {}

###############################################################################################
# Creation of subaccount
###############################################################################################
resource "btp_subaccount" "project" {
  name      = var.subaccount_name
#  subdomain = "btp-gp${random_uuid.uuid.result}"
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
}
data "btp_whoami" "me" {}

data "btp_subaccount_environments" "all" {
  subaccount_id = btp_subaccount.project.id
}

###############################################################################################
# Creation of Cloud Foundry environment
###############################################################################################
locals {
  cf_landscape_labels = [
    for env in data.btp_subaccount_environments.all.values : env.landscape_label
    if env.environment_type == "cloudfoundry"
  ]
}

resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = btp_subaccount.project.id
  name             = btp_subaccount.project.subdomain
  landscape_label  = local.cf_landscape_labels[0]
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "standard"
  # ATTENTION: some regions offer multiple environments of a kind and you must explicitly select the target environment in which
  # the instance shall be created using the parameter landscape label. 
  # available environments can be looked up using the btp_subaccount_environments datasource
  parameters = jsonencode({
#    instance_name = btp_subaccount.project.subdomain
    instance_name = local.project_subaccount_cf_org
  })

/*
  timeouts = {
    create = "1h"
    update = "35m"
    delete = "30m"
  }
*/
}

###############################################################################################
# Assignment of users as sub account administrators
###############################################################################################
resource "btp_subaccount_role_collection_assignment" "subaccount-admins" {
  for_each             = toset("${var.subaccount_admins}")
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
}

/*
######################################################################
# Add entitlement for BAS, Subscribe BAS and add roles
######################################################################
resource "btp_subaccount_entitlement" "bas" {
  subaccount_id = btp_subaccount.project.id
# TODO
#  service_name  = "sapappstudio"
#  plan_name     = var.bas_plan_name
  service_name  = "canary-saas"
  plan_name     = "free"
}
resource "btp_subaccount_subscription" "bas-subscribe" {
  subaccount_id = btp_subaccount.project.id
# TODO
#  app_name      = "sapappstudio"
#  plan_name     = var.bas_plan_name
  app_name  = "canary-saas"
  plan_name     = "free"

  depends_on    = [btp_subaccount_entitlement.bas]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Business_Application_Studio_Administrator"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "bas_admins" {
  for_each             = toset("${var.bas_admins}")
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Business_Application_Studio_Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.bas-subscribe]
}

# ------------------------------------------------------------------------------------------------------
# Assign role collection "Business_Application_Studio_Developer"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "bas_developer" {
  for_each             = toset("${var.bas_developers}")
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Business_Application_Studio_Developer"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.bas-subscribe]
}

*/

######################################################################
# Add Build Workzone entitlement subscription and role Assignment
######################################################################
resource "btp_subaccount_entitlement" "build_workzone" {
  subaccount_id = btp_subaccount.project.id
  service_name  = "SAPLaunchpad"
# TODO
#  plan_name     = var.build_workzone_plan_name
  plan_name     = "standard"
}
resource "btp_subaccount_subscription" "build_workzone_subscribe" {
  subaccount_id = btp_subaccount.project.id
  app_name      = "SAPLaunchpad"
# TODO
#  plan_name     = var.build_workzone_plan_name
  plan_name     = "standard"
  depends_on    = [btp_subaccount_entitlement.build_workzone]
}
# ------------------------------------------------------------------------------------------------------
# Assign role collection "Launchpad_Admin"
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount_role_collection_assignment" "launchpad_admin" {
  for_each             = toset("${var.launchpad_admins}")
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Launchpad_Admin"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.build_workzone_subscribe]
}


######################################################################
# Create HANA entitlement subscription
######################################################################
resource "btp_subaccount_entitlement" "hana-cloud" {
  subaccount_id = btp_subaccount.project.id
  service_name  = "hana-cloud"
# TODO
#  plan_name     = var.hana-cloud_plan_name
  plan_name     = "hana"
}
# Enable HANA Cloud Tools
resource "btp_subaccount_entitlement" "hana-cloud-tools" {
  subaccount_id = btp_subaccount.project.id
#  service_name  = "hana-cloud-tools"
  service_name  = "hana-cloud-tools-sap_eu-de-1"
  plan_name     = "tools"
}
resource "btp_subaccount_subscription" "hana-cloud-tools" {
  subaccount_id = btp_subaccount.project.id
 # app_name      = "hana-cloud-tools"
  app_name      = "hana-cloud-tools-sap_eu-de-1"
  plan_name     = "tools"
  depends_on    = [btp_subaccount_entitlement.hana-cloud-tools]
}
resource "btp_subaccount_entitlement" "hana-hdi-shared" {
  subaccount_id = btp_subaccount.project.id
  service_name  = "hana"
  plan_name     = "hdi-shared"
}
