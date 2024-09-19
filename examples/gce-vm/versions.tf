# version requirement

terraform {
  required_version = ">= 1.9.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.3.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.3.0"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}
