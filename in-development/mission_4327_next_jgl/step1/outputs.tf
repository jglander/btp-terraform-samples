output "subaccount_id" {
  value = btp_subaccount.project.id
}

output "cf_landscape_label" {
  value = terraform_data.cf_landscape_label.output
}

output "cf_org_id" {
  value = btp_subaccount_environment_instance.cloudfoundry.platform_id
}

output "cf_api_url" {
  value = lookup(jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels), "API Endpoint", "not found")
}

output "sap_launchpad_subscription_url" {
  value       = btp_subaccount_subscription.build_workzone_subscribe.subscription_url
  description = "SAP Build Work Zone, standard edition subscription URL."
}
