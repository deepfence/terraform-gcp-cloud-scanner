# provider "google" {
#   project = var.project
#   region  = var.region
# }

# creates service account with read only access for resources
resource "google_service_account" "container_sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service account for container"
}

# deploys application image in cloud run container with required access
module "container" {
  source             = "../../modules/services/container"
  name               = "${var.name}-container"
  mode               = var.mode
  mgmt-console-url   = var.mgmt-console-url
  mgmt-console-port  = var.mgmt-console-port
  deepfence-key      = var.deepfence-key
  image_name         = var.image_name
  project_id         = data.google_client_config.current.project
  container_sa_email = google_service_account.container_sa.email
  cpu                = 2
  multi-project-ids = [for project in data.google_project.all_projects : project.project_id]
  org-acc-id        = data.google_organization.org.id
}
