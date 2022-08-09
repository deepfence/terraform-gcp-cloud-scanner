# imports org data

data "google_organization" "org" {
  domain = var.organization_domain
}

# creates service account with read only access for resources

resource "google_service_account" "container_sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service account for container"
}

# assigns read only resource access at org level

resource "google_organization_iam_member" "organization_image_puller" {
  org_id = data.google_organization.org.org_id

  role   = "roles/run.viewer"
  member = "serviceAccount:${google_service_account.container_sa.email}"  
}

# deploys application image in cloud run container with required access

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



