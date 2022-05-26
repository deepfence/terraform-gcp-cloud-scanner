resource "google_secret_manager_secret" "secure_api_secret" {
  secret_id = "${var.name}-deepfence-secure-api-secret"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_iam_member" "secret_reader" {
  secret_id = google_secret_manager_secret.secure_api_secret.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.cloud_scanning_sa_email}"
}

resource "google_secret_manager_secret_version" "secure_api_secret" {
  secret = google_secret_manager_secret.secure_api_secret.id

  secret_data = var.deepfence_secure_api_token
}

