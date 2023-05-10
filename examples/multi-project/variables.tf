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
  default     = ""
}

variable "mgmt-console-port" {
  type        = string
  description = "mgmt-console-port"
  default     = "443"
}

variable "deepfence-key" {
  type        = string
  description = "deepfence-key"
  default     = ""
}

variable "image_name" {
  type        = string
  description = "Cloud Scanner docker image"
  default     = "docker.io/deepfenceiowfds/cloud-scanner:v2"
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

# variable "project" {
#   type = string
# }

# variable "region" {
#   type = string
# }
