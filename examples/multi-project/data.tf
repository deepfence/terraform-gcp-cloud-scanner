# importing google cloud current config

data "google_organization" "org_by_domain" {
  domain = var.org_domain
}

data "google_client_config" "current" {}

data "google_projects" "all_projects" {
  filter = "name:*"
}

output "current_project" {
  value = var.project_id
}
