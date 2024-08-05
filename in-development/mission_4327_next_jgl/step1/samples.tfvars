# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
cli_server_url="https://canary.cli.btp.int.sap/"

# Your global account subdomain
#globalaccount = "myglobalaccount"
globalaccount   = "775253e0-3e95-4cde-b005-cdc3688cdc2c"

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
# Subaccount configuration
#region          = "us10"
region          = "eu12"

#subaccount_name = "DCM Goldenpath"
subaccount_name = "4327-jgl-can-0508za"

# To add extra users to the subaccount, the user running the script becomes the admin, without inclusion in admins.
subaccount_admins = ["joe.do@sap.com", "jane.do@sap.com"]
#------------------------------------------------------------------------------------------------------
# Entitlements plan update
#------------------------------------------------------------------------------------------------------
# For production use of Business Application Studio, upgrade the plan from the `free-tier` to the appropriate plan e.g standard-edition
#service_plan__bas = "standard-edition"
service_plan__bas = "free"

#-------------------------------------------------------------------------------------------------------
# For production use of Build Workzone, upgrade the plan from the `free-tier` to the appropriate plan e.g standard
service_plan__build_workzone = "standard"
#--------------------------------------------------------------------------------------------------------
# For production use of HANA, upgrade the plan from the `free-tier` to the appropriate plan e.g hana
service_plan__hana_cloud = "hana"

#------------------------------------------------------------------------------------------------------
# Cloud Foundry
#------------------------------------------------------------------------------------------------------
# Choose a unique organization name e.g., based on the global account subdomain and subaccount name
cf_org_name = "<unique_org_name>"

# Additional Cloud Foundry users
cf_space_developers = ["john.doe@sap.com"]
cf_space_managers   = ["john.doe@sap.com"]
cf_org_admins       = ["john.doe@sap.com"]
cf_org_users        = ["john.doe@sap.com"]
