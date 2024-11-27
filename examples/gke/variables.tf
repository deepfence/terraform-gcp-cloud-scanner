variable "project_id" {
  type        = string
  description = "gcp project id"
}

variable "cluster_name" {
  type        = string
  description = "target cluster to install cloud scanner"
}

variable "cluster_location" {
  type        = string
  description = "target cluster location/region"
}

variable "gke_host" {
  type = string
}

variable "gke_token" {
  type = string
}

variable "gke_cluster_ca_certificate" {
  type = string
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

variable "cloud_scanner_chart_name" {
  type        = string
  default     = "deepfence-cloud-scanner"
  description = "cloud scanner chart name"
}

variable "cloud_scanner_chart_version" {
  type        = string
  default     = "2.5.1"
  description = "cloud scanner chart version"
}

variable "cloud_scanner_image" {
  type        = string
  default     = "quay.io/deepfenceio/cloud_scanner_ce"
  description = "quay.io/deepfenceio/cloud_scanner_ce if using ThreatMapper. quay.io/deepfenceio/cloud_scanner if using ThreatStryker"
}

variable "cloud_scanner_image_tag" {
  type        = string
  default     = "2.5.1"
  description = "cloud scanner container image tag"
}

variable "mgmt-console-url" {
  type        = string
  description = "deepfence management clonsole url"
}

variable "mgmt-console-port" {
  type        = string
  description = "deepfence management console port"
  default     = "443"
}

variable "deepfence-key" {
  type        = string
  description = "deepfence API key, Get it from console UI -> Settings -> User Management"
}

variable "log_level" {
  type        = string
  description = "cloud scanner log level"
  default     = "info"
}

variable "isOrganizationDeployment" {
  type    = bool
  default = false
}

# optional variables
# required if isOrganizationDeployment is true
variable "organizationAccountID" {
  type        = string
  default     = ""
  description = "organization project id"
}

variable "deployedAccountID" {
  type        = string
  default     = ""
  description = "target project where cloud scanner is deployed in org mode"
}

# extra helm values for the helm chart 
# uses same sytax as that of helm_release for keys and values
variable "extra_helm_values" {
  type    = map(string)
  default = {}
}
