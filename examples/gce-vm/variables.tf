variable "project_id" {
  type        = string
  description = "gcp project id"
}

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "deepfence-cloud-scanner"
}

variable "cloud_scanner_role" {
  type        = string
  default     = "roles/iam.securityReviewer"
  description = "cloud scanner role, it can be roles/iam.securityReviewer or roles/viewer"
}

variable "isOrganizationDeployment" {
  type    = bool
  default = false
}

