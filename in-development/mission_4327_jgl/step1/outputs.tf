output "cf_landscape_labels" {
  value = local.cf_landscape_labels
}

output "cf_api_url" {
    value = jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels)["API Endpoint"]
}

output "cf_org" {
    value = btp_subaccount_environment_instance.cloudfoundry.platform_id
}

output "subaccount_id" {
    value = btp_subaccount.project.id
} 

output "sap_launchpad_subscription_url" {
  value       = btp_subaccount_subscription.build_workzone_subscribe.subscription_url
  description = "SAP Build Work Zone, standard edition subscription URL."
}
