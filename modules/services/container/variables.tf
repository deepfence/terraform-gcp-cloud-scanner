# general

variable "project_id" {
  type        = string
  description = "organizational member project ID where the workload is going to be deployed"
}

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "deepfence-cloud-scanner"
}

# IAM

variable "container_sa_email" {
  type        = string
  description = "Container service account email"
}

# container variables
variable "mgmt-console-url" {
  type        = string
  description = "mgmt-console-url"
}

variable "mgmt-console-port" {
  type        = string
  description = "mgmt-console-port"
}

variable "deepfence-key" {
  type        = string
  description = "deepfence-key"
}

variable "project_name" {
  type        = string
  description = "GCP project name"
  default     = ""
}

variable "max_instances" {
  type        = number
  description = "Max number of instances for the cloud scanner"
  default     = 1
}

variable "min_instances" {
  type        = number
  description = "Min number of instances for the cloud scanner"
  default     = 1
}

variable "image_name" {
  type        = string
  default     = "us-east1-docker.pkg.dev/deepfenceio/deepfence/cloud_scanner_ce:2.4.0"
  description = "Deepfence cloud scanner image. GCP only allows the deployment of images that are registered in gcr.io"
}

variable "cpu" {
  type        = string
  default     = "1"
  description = "Amount of CPU to reserve for cloud-scanner cloud run service"
}

variable "memory" {
  type        = string
  default     = "2048Mi"
  description = "Amount of memory to reserve for cloud-scanner cloud run service"
}

variable "location" {
  type        = string
  default     = "us-central1"
  description = "The region in which cloud run service would be deployed"
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


variable "is_organizational" {
  type        = bool
  default     = false
  description = "whether Deepfence cloud scanner should be deployed in an organizational setup"
}