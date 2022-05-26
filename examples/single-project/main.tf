provider "google" {
   project = "dev1-164606"
   region  = "us-central-1"
}

resource "google_service_account" "connector_sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service account for cloud-connector"
}

module "cloud_connector" {
  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-cloudconnector"

  deepfence_secure_endpoint  = "https://dev.deepfence.com"
  deepfence_secure_api_token = "test"

  project_id                 = data.google_client_config.current.project
  cloud_connector_sa_email   = google_service_account.connector_sa.email
  secure_api_token_secret_id = module.secure_secrets.secure_api_token_secret_name

}

module "secure_secrets" {
  source = "../../modules/infrastructure/secrets"
  name   = "${var.name}-cloudconnector"

  cloud_scanning_sa_email = google_service_account.connector_sa.email
  deepfence_secure_api_token = "test"
}