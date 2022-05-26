variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "cloud-compliance-scanner"
}

variable "cloud_scanning_sa_email" {
  type        = string
  description = "Cloud-scanning SA email"
}

variable "deepfence_secure_api_token" {
  type        = string
  description = "Deepfence's Secure API Token"
  sensitive   = true
}