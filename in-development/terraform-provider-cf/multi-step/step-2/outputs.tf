output "subaccount_id" {
    value = var.subaccount_id
}

output "cf_landscape_labels" {
  value = join(",", var.cf_landscape_labels)
}

output "cf_org" {
    value = var.cf_org
}

output "cf_api_url" {
    value = var.cf_api_url
}

output "cf_space" {
    value = cloudfoundry_space.dev.name
}