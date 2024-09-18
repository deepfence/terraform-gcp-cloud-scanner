# importing google cloud current config
data "google_client_config" "current" {}

# required for org account deployment
# can be removed when deploying to single account
data "google_projects" "projects" {
  filter = "name:*"
}