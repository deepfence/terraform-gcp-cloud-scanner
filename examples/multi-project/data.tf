# importing google cloud current config

data "google_organization" "org" {}

data "google_client_config" "current" {}

data "google_project" "all_projects" {
  count = length(data.google_organization.org.projects)

  project_id = data.google_organization.org.projects[count.index].project_id
}

output "projects" {
  value = [for project in data.google_project.all_projects : project.project_id]
}