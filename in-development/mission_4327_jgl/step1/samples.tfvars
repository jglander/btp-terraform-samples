# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------

cli_server_url="https://canary.cli.btp.int.sap/"

# Your global account subdomain
#globalaccount   = "myglobalaccount"
globalaccount   = "775253e0-3e95-4cde-b005-cdc3688cdc2c"

#region          = "us10"
region          = "eu12"

#subaccount_name = "DCM Goldenpath"
subaccount_name = "4327-jgl-can-0508aa"

#cf_org_name     = "cf-org-jgl-can-0508a"
# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
# To add extra users to the subaccount, the user running the script becomes the admin, without inclusion in admins.
#subaccount_admins = ["joe.do@sap.com", "jane.do@sap.com"]

# To Create Cloudfoundry Org and add users with specific roles
#------------------------------------------------------------------------------------------------------
# Entitlements plan update
#------------------------------------------------------------------------------------------------------
# For production use of Business Application Studio, upgrade the plan from the `free-tier` to the appropriate plan e.g standard-edition
#bas_plan_name = "standard-edition"

#-------------------------------------------------------------------------------------------------------
#For production use of Build Workzone, upgrade the plan from the `free-tier` to the appropriate plan e.g standard
build_workzone_plan_name = "standard"
#--------------------------------------------------------------------------------------------------------
# For production use of HANA, upgrade the plan from the `free-tier` to the appropriate plan e.g hana
#hana-cloud_plan_name = "hana"

# ------------------------------------------------------------------------------------------------------
# USER ROLES
# ------------------------------------------------------------------------------------------------------
subaccount_admins = ["jens.glander@sap.com"]

launchpad_admins  = ["jens.glander@vodafone.de", "jens.glander@sap.com"]

bas_admins        = ["jens.glander@vodafone.de", "jens.glander@sap.com"]
bas_developers    = ["jens.glander@vodafone.de", "jens.glander@sap.com"]

