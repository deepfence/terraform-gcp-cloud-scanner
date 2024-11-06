# Cloud Scanner in Google Cloud<br/>[ Example :: GCE compute instance Cloud Scanner ] 

Deploy Deepfence Cloud Scanner for Google Cloud on a GKE cluster using workload identity.<br/>

### Notice
**Deployment cost** - This example will create resources that cost money.<br/>Run `terraform destroy` when you don't need them anymore

## Prerequisites

1. Configure [Terraform **GCP** Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
2. Following **roles** are required in your GCP organization/project credentials
   * _Owner_
3. Besides, the following GCP **APIs must be enabled** to deploy resources correctly:

* [Identity and access management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)

## Usage
- For Single Project
Copy the code below and paste it into a .tf file on your local machine.

```terraform

data "google_client_config" "current" {}

module "cloud_scanner_example_single_project" {
  source     = "deepfence/cloud-scanner/gcp//examples/gce-vm"
  version    = "0.9.0"
  name       = "deepfence-cloud-scanner"
  # project_id example: dev1-123456
  project_id = "<PROJECT_ID>"
}


output "service_account_email" {
  value = module.cloud_scanner_example_single_project.service_account_email
}
```

- For Organization Projects 
Copy the code below and paste it into a .tf file on your local machine.

```terraform

data "google_client_config" "current" {}

module "cloud_scanner_example_single_project" {
  source                   = "deepfence/cloud-scanner/gcp//examples/gce-vm"
  version                  = "0.9.0"
  name                     = "deepfence-cloud-scanner"
  # project_id example: dev1-123456
  project_id               = "<PROJECT_ID>"
  isOrganizationDeployment = true
}

output "service_account_email" {
  value = module.cloud_scanner_example_multiple_project.service_account_email
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.3.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 6.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service_account_roles"></a> [service\_account\_roles](#module\_service\_account\_roles) | ../../modules/gke/service-account | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.preexisting](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_projects.projects](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/projects) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_scanner_role"></a> [cloud\_scanner\_role](#input\_cloud\_scanner\_role) | cloud scanner role, it can be roles/iam.securityReviewer or roles/viewer | `string` | `"roles/iam.securityReviewer"` | no |
| <a name="input_isOrganizationDeployment"></a> [isOrganizationDeployment](#input\_isOrganizationDeployment) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"deepfence-cloud-scanner"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | gcp project id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | n/a |
<!-- END_TF_DOCS -->