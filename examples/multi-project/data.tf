# importing google cloud current config

data "google_organization" "org" {}

data "google_client_config" "current" {}

data "google_project" "all_projects" {
  parent = "organizations/${data.google_organization.org.id}"
}

output "projects" {
  value = [for project in data.google_project.all_projects : project.project_id]
}