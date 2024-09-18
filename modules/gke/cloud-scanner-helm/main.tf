locals {
  values = {
    "image.repository"      = var.cloud_scanner_image,
    "image.tag"             = var.cloud_scanner_image_tag,
    "managementConsoleUrl"  = var.mgmt-console-url,
    "managementConsolePort" = var.mgmt-console-port,
    "deepfenceKey.key"      = var.deepfence-key,
    "logLevel"              = var.log_level

    "cloudAccount.cloudProvider" = "gcp",
    "cloudAccount.accountID"     = var.project_id,
    "cloudAccount.region"        = var.cluster_location,

    "cloudAccount.isOrganizationDeployment" = var.isOrganizationDeployment
    "cloudAccount.deployedAccountID"        = var.deployedAccountID
    "cloudAccount.organizationAccountID"    = var.organizationAccountID

    "serviceAccount.name"                                           = var.gcp_sa_name
    "serviceAccount.annotations.iam\\.gke\\.io/gcp-service-account" = var.gcp_sa_email,
  }
}

resource "helm_release" "cs" {
  name             = var.name
  repository       = "https://deepfence-helm-charts.s3.amazonaws.com/cloud-scanner"
  chart            = var.cloud_scanner_chart_name
  version          = var.cloud_scanner_chart_version
  namespace        = var.k8s_namespace
  create_namespace = true
  upgrade_install  = true

  dynamic "set" {
    for_each = merge(local.values, var.extra_helm_values)
    content {
      name  = set.key
      value = set.value
    }
  }
}
