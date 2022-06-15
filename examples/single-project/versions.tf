# version requirement

terraform {
  required_version = ">= 0.15.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.21.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.21.0"
    }
  }
}