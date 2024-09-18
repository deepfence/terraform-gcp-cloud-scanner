# version requirement

terraform {
  required_version = ">= 1.9.5"

  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
  }
}
