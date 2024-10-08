# ------------------------------------------------------------------------------------------------------
# Create the Cloud Foundry space
# ------------------------------------------------------------------------------------------------------
resource "cloudfoundry_space" "dev" {
  name = "dev"
  org  = var.cf_org_id
}

# ------------------------------------------------------------------------------------------------------
# SETUP ALL SERVICES FOR CF USAGE
# ------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
data "btp_whoami" "me" {}

locals {
  # Remove current user
  cf_org_admins = setsubtract(toset(var.cf_org_admins), [data.btp_whoami.me.email])

  cf_space_managers   = var.cf_space_managers
  cf_space_developers = var.cf_space_developers
}

# ------------------------------------------------------------------------------------------------------
# cf_org_admins: Assign organization_user role
# ------------------------------------------------------------------------------------------------------
resource "cloudfoundry_org_role" "organization_user" {
  for_each = toset(local.cf_org_admins)
  username = each.value
  type     = "organization_user"
  org      = var.cf_org_id
  origin   = var.origin_key
}

# ------------------------------------------------------------------------------------------------------
# cf_org_admins: Assign organization_manager role
# ------------------------------------------------------------------------------------------------------
resource "cloudfoundry_org_role" "organization_manager" {
  for_each   = toset(local.cf_org_admins)
  username   = each.value
  type       = "organization_manager"
  org        = var.cf_org_id
  origin     = var.origin_key
  depends_on = [cloudfoundry_org_role.organization_user]
}

# ------------------------------------------------------------------------------------------------------
# cf_space_managers: Assign space_manager role
# ------------------------------------------------------------------------------------------------------
# Define Space Manager role
resource "cloudfoundry_space_role" "space_manager" {
  for_each   = toset(local.cf_space_managers)
  username   = each.value
  type       = "space_manager"
  space      = cloudfoundry_space.dev.id
  origin     = var.origin_key
  depends_on = [cloudfoundry_org_role.organization_manager]
}

# ------------------------------------------------------------------------------------------------------
# cf_space_developers: Assign space_developer role
# ------------------------------------------------------------------------------------------------------
resource "cloudfoundry_space_role" "space_developer" {
  for_each   = toset(local.cf_space_developers)
  username   = each.value
  type       = "space_developer"
  space      = cloudfoundry_space.dev.id
  origin     = var.origin_key
  depends_on = [cloudfoundry_org_role.organization_manager]
}
