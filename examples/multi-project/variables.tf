# general

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "cloud-scanner-saurabh"
}

# container variables

variable "mode" {
  type        = string
  description = "mode"
  default     = "service"
}

variable "mgmt-console-url" {
  type        = string
  description = "mgmt-console-url"
  default     = "142.93.216.241"
}

variable "mgmt-console-port" {
  type        = string
  description = "mgmt-console-port"
  default     = "443"
}

variable "deepfence-key" {
  type        = string
  description = "deepfence-key"
  default     = "d024c380-bc9d-4153-89f7-30f587950d09"
}

variable "image_name" {
  type        = string
  description = "Cloud Scanner docker image"
  default     = "docker.io/deepfenceio/cloud-scanner:v2"
}

variable "org_domain" {
  type        = string
  description = "Org Domain Name"
  default = "deepfence.io"
}

variable "org_id" {
  type        = string
  description = "Organisation Id"
  default = ""
}

variable "project_id" {
  type        = string
  description = "organizational member project ID where the workload is going to be deployed"
  default = "astute-house-189713"
}
# variable "project" {
#   type = string
# }

# variable "region" {
#   type = string
# }
