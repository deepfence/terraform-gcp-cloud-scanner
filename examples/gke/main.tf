# create a gcp service account
resource "google_service_account" "preexisting" {
  account_id   = var.name
  project      = var.project_id
  display_name = "Service account for deepfence cloud scanner"
}

# creates required role bindings for workload identity
module "service_account_roles" {
  source                   = "../../modules/gke/service-account"
  project_id               = var.project_id
  service_account_name     = google_service_account.preexisting.name
  service_account_email    = google_service_account.preexisting.email
  k8s_namespace            = var.k8s_namespace
  cloud_scanner_role       = var.cloud_scanner_role
  isOrganizationDeployment = var.isOrganizationDeployment
  org_project_ids          = var.isOrganizationDeployment ? toset(data.google_projects.projects.projects.*.project_id) : toset([])
  enable_workload_identity = true

  depends_on = [
    google_service_account.preexisting,
  ]
}

provider "helm" {
  kubernetes {
    host                   = var.gke_host
    token                  = var.gke_token
    cluster_ca_certificate = var.gke_cluster_ca_certificate
  }
}

# install cloud scanner on the target cluster
# uses the workload identity and service accounts created previously
module "cloud_scanner_helm" {
  source                   = "../../modules/gke/cloud-scanner-helm"
  gcp_sa_name              = var.name
  gcp_sa_email             = google_service_account.preexisting.email
  k8s_namespace            = var.k8s_namespace
  cluster_name             = var.cluster_name
  cluster_location         = var.cluster_location
  project_id               = var.project_id
  isOrganizationDeployment = var.isOrganizationDeployment
  deployedAccountID        = var.deployedAccountID
  organizationAccountID    = var.organizationAccountID
  mgmt-console-url         = var.mgmt-console-url
  deepfence-key            = var.deepfence-key
  cloud_scanner_image      = var.cloud_scanner_image

  depends_on = [
    google_service_account.preexisting,
    module.workload_identity,
  ]
}
