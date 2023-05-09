# importing google cloud current config

data "google_organization" "org" {}

data "google_client_config" "current" {}

data "google_projects" "all_projects" {
  filter = "parent.id:${data.google_organization.org.id}"
}
