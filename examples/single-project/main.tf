provider "google" {
   project = "dev1-164606"
   region  = "asia-east1"
}
# creates service account with read only access for resources

resource "google_service_account" "container_sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service account for container"
}

module "container" {
  source = "../../modules/services/container"
  name   = "${var.name}-container"
  
  mode                          = var.mode
  mgmt-console-url              = var.mgmt-console-url 
  mgmt-console-port             = var.mgmt-console-port
  deepfence-key                 = var.deepfence-key

  project_id                    = data.google_client_config.current.project
  container_sa_email            = google_service_account.container_sa.email

}

