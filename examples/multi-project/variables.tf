variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "deepfence-cloud-scanner"
}

# container variables

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
  default     = "us-east1-docker.pkg.dev/deepfenceio/deepfence/cloud_scanner_ce:2.4.0"
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
  type        = string
  description = "location where the workload is going to be deployed"
}


variable "vpc" {
  type        = string
  default     = ""
  description = "VPC Network name if connecting to console via private ip"
}

variable "ip_cidr_range_svpca" {
  type        = string
  default     = "11.0.0.0/28"
  description = "IP CIDR Range for serverless vpc connector to be created for private ip console"
}

variable "cpu" {
  type        = string
  default     = "4"
  description = "Amount of CPU to reserve for cloud-scanner cloud run service"
}

variable "memory" {
  type        = string
  default     = "8192Mi"
  description = "Amount of memory to reserve for cloud-scanner cloud run service"
}

variable "labels" {
  type = map(string)
  default = {
    name = "deepfence-cloud-scanner"
  }
}

variable "log_level" {
  type        = string
  default     = "info"
  description = "Log level"
  validation {
    condition     = contains(["error", "warn", "info", "debug", "trace"], var.log_level)
    error_message = "Must be one of error, warn, info, debug, trace"
  }
}