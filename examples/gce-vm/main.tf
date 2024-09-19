# create a gcp service account
resource "google_service_account" "preexisting" {
  account_id   = var.name
  project      = var.project_id
  display_name = "Service account for deepfence cloud scanner"
}

# creates required role bindings for service account
module "service_account_roles" {
  source                   = "../../modules/gke/service-account"
  project_id               = var.project_id
  service_account_name     = google_service_account.preexisting.name
  service_account_email    = google_service_account.preexisting.email
  cloud_scanner_role       = var.cloud_scanner_role
  isOrganizationDeployment = var.isOrganizationDeployment
  org_project_ids          = var.isOrganizationDeployment ? toset(data.google_projects.projects.projects.*.project_id) : toset([])
  enable_workload_identity = false

  depends_on = [
    google_service_account.preexisting,
  ]
}

