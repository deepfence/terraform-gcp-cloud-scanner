# importing google cloud current config

data "google_client_config" "current" {}

data "google_projects" "projects" {
  filter = "name:*"
}