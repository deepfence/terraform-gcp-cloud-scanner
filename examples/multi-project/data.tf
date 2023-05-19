data "google_organization" "org_by_domain" {
  domain = var.org_domain
}

data "google_projects" "all_projects" {
  filter = "name:*"
}