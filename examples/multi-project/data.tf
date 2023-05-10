# importing google cloud current config

data "google_organization" "org_by_domain" {
  count = var.org_domain != "" ? 0 : 1
  domain = try(var.org_domain, null)
}

data "google_client_config" "current" {}

data "google_projects" "all_projects" {
  filter = "parent.id:${data.google_organization.org_by_domain.id}"
}
