variable "project_id" {
  type        = string
  description = "project id where the cloud scanner is installed"
}

variable "org_project_ids" {
  type    = list(string)
  default = []
}

variable "service_account_name" {
  type        = string
  description = "service account name"
}

variable "service_account_email" {
  type        = string
  description = "service account email"
}

variable "cloud_scanner_role" {
  type        = string
  default     = "roles/iam.securityReviewer"
  description = "cloud scanner role, it can be set to roles/iam.securityReviewer or roles/viewer"
}

variable "k8s_service_account_name" {
  type        = string
  description = "kubernetes service account name"
  default     = "deepfence-cloud-scanner"
}

variable "k8s_namespace" {
  type        = string
  description = "namespace to install deepfence cloud scanner"
  default     = "deepfence"
}

variable "isOrganizationDeployment" {
  type    = bool
  default = false
}
