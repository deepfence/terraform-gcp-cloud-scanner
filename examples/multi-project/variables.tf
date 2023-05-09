# general

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "deepfence-cloud-scanner"
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
  default     = "64.227.142.80"
}

variable "mgmt-console-port" {
  type        = string
  description = "mgmt-console-port"
  default     = "443"
}

variable "deepfence-key" {
  type        = string
  description = "deepfence-key"
  default     = "c822261d-1975-470a-87db-dbfad11d839c"
}

variable "image_name" {
  type        = string
  description = "Cloud Scanner docker image"
  default     = "docker.io/deepfenceiowfds/cloud-scanner:v2"
}

# variable "project" {
#   type = string
# }

# variable "region" {
#   type = string
# }
