# importing google cloud current config

data "google_client_config" "current" {}

data "google_project" "project" {
  project_id = var.project_id
}