output "secure_api_token_secret_name" {
  value       = google_secret_manager_secret.secure_api_secret.secret_id
  description = "Deepfence's Secure API Token secret name"
}