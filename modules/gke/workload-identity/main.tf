locals {
  sa_member       = "serviceAccount:${var.service_account_email}"
  workload_member = "serviceAccount:${var.project_id}.svc.id.goog[${var.k8s_namespace}/${var.k8s_service_account_name}]"
}

resource "google_project_iam_member" "project_viewer" {
  for_each = var.isOrganizationDeployment ? toset(var.org_project_ids) : toset([var.project_id])

  project = each.value
  role    = var.cloud_scanner_role
  member  = local.sa_member
}

resource "google_project_iam_member" "project_browser" {
  for_each = toset(var.org_project_ids)

  project = each.value
  role    = "roles/browser"
  member  = local.sa_member
}

resource "google_service_account_iam_member" "main" {
  service_account_id = var.service_account_name
  role               = "roles/iam.workloadIdentityUser"
  member             = local.workload_member
}
