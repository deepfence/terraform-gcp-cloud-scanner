# creates service account with read only access for resources
resource "google_service_account" "container_sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service account for container"
  project      = var.project_id
}

# deploys application image in cloud run container with required access
module "container" {
  source              = "../../modules/services/multi-project-container"
  name                = "${var.name}-container"
  mgmt-console-url    = var.mgmt-console-url
  mgmt-console-port   = var.mgmt-console-port
  deepfence-key       = var.deepfence-key
  image_name          = var.image_name
  project_id          = var.project_id
  container_sa_email  = google_service_account.container_sa.email
  cpu                 = var.cpu
  memory              = var.memory
  multi-project-ids   = join(",", data.google_projects.all_projects.projects.*.project_id)
  org-acc-id          = data.google_organization.org_by_domain.id
  location            = var.region
  ip_cidr_range_svpca = var.ip_cidr_range_svpca
  vpc                 = var.vpc
  labels              = var.labels
  is_organizational   = "true"
  log_level           = var.log_level
}