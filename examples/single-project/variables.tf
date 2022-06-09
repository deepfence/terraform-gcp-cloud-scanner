# general

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "cloud-compliance-scanner"
}

# container variables

variable "mode" {
  type        = string
  description = "mode"
  default     = ""
}

variable "mgmt-console-url" {
  type        = string
  description = "mgmt-console-url"
  default     = ""
}

variable "mgmt-console-port" {
  type        = string
  description = "mgmt-console-port"
  default     = ""
}

variable "deepfence-key" {
  type        = string
  description = "deepfence-key"
  default     = ""
}
