variable "deepfence_secure_endpoint" {
  type        = string
  description = "deepfence's Secure API URL"
}

variable "extra_envs" {
  type        = map(string)
  default     = {}
  description = "Extra environment variables for the Cloud Connector instance"
}

variable "is_organizational" {
  type        = bool
  default     = false
  description = "whether secure-for-cloud should be deployed in an organizational setup"
}

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "cloud-compliance-scanner-cloudconnector"
}

variable "max_instances" {
  type        = number
  description = "Max number of instances for the Cloud Connector"
  default     = 1
}

variable "image_name" {
  type        = string
  default     = "hub.docker.com/r/ramananr/cloud-compliance:latest"
  description = "Sysdig Owned Cloud Connector public image. GCP only allows the deployment of images that are registered in gcr.io"
}

variable "cpu" {
  type        = string
  default     = "1"
  description = "Amount of CPU to reserve for cloud-connector cloud run service"
}

variable "memory" {
  type        = string
  default     = "2048Mi"
  description = "Amount of memory to reserve for cloud-connector cloud run service"
}

variable "deepfence_secure_api_token" {
  type        = string
  description = "Deepfence's Secure API Token"
  sensitive   = true
}

variable "cloud_connector_sa_email" {
  type        = string
  description = "Cloud Connector service account email"
}

variable "project_id" {
  type        = string
  description = "organizational member project ID where the secure-for-cloud workload is going to be deployed"
}

variable "secure_api_token_secret_id" {
  type        = string
  description = "Sysdig Secure API token secret id"
}

