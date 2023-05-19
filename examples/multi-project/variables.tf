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
}

variable "mgmt-console-port" {
  type        = string
  description = "mgmt-console-port"
  default     = "443"
}

variable "deepfence-key" {
  type        = string
  description = "deepfence-key"
}

variable "image_name" {
  type        = string
  description = "Cloud Scanner docker image"
  default     = "docker.io/deepfenceio/cloud-scanner:v2"
}

variable "org_domain" {
  type        = string
  description = "Org Domain Name"
}

variable "project_id" {
  type        = string
  description = "organizational member project ID where the workload is going to be deployed"
}

variable "region" {
  type = string
  description = "location where the workload is going to be deployed"
}