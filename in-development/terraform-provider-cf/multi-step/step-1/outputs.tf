output "cf_landscape_labels" {
  value = local.cf_landscape_labels
}

output "cf_api_url" {
    value = jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels)["API Endpoint"]
}

output "cf_org" {
    value = btp_subaccount_environment_instance.cloudfoundry.platform_id
}

output "custom_ias_tenant" {
    value = var.custom_ias_tenant
}

output "subaccount_id" {
    value = btp_subaccount.project.id
} 