# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
cli_server_url="https://canary.cli.btp.int.sap/"

# Your global account subdomain
#globalaccount   = "youraccount"
globalaccount   = "775253e0-3e95-4cde-b005-cdc3688cdc2c"

#region          = "us10"
region          = "eu12"

#subaccount_name = "Discovery Center mission 3260 - Process and approve your invoices with SAP Build Process Automation"
subaccount_name = "3260-jgl-can-0408a"

service_plan__sap_process_automation = "free"

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt!)
# ------------------------------------------------------------------------------------------------------
# Don't add the user, that is executing the TF script to subaccount_admins or subaccount_service_admins!
subaccount_admins                  = ["jane.doe@test.com", "john.doe@test.com"]
subaccount_service_admins          = ["jane.doe@test.com", "john.doe@test.com"]

process_automation_admins       = ["jane.doe@test.com", "john.doe@test.com"]
process_automation_developers   = ["jane.doe@test.com", "john.doe@test.com"]
process_automation_participants = ["jane.doe@test.com", "john.doe@test.com"]

