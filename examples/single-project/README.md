# Cloud Scanner in Google Cloud<br/>[ Example :: Single-Project ] 

Deploy Cloud Scanner for Google Cloud in a single project.<br/>

### Notice
**Deployment cost** - This example will create resources that cost money.<br/>Run `terraform destroy` when you don't need them anymore

## Prerequisites

1. Configure [Terraform **GCP** Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
2. Following **roles** are required in your GCP organization/project credentials
   * _Owner_
3. Besides, the following GCP **APIs must be enabled** to deploy resources correctly:

* [Identity and access management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)
* [Cloud Run API](https://console.cloud.google.com/marketplace/product/google/run.googleapis.com)

## Usage
Copy the code below and paste it into a .tf file on your local machine.

```terraform

module "cloud-scanner_example_single-project" {
  source              = "deepfence/cloud-scanner/gcp//examples/single-project"
  version             = "0.4.0"
  name                = "deepfence-cloud-scanner"
  # mgmt-console-url: deepfence.customer.com or 22.33.44.55
  mgmt-console-url    = "<Console URL>"
  mgmt-console-port   = "443"
  deepfence-key       = "<Deepfence-key>"
  image_name          = "us-east1-docker.pkg.dev/deepfenceio/deepfence/cloud-scanner:2.2.0"
  # project_id example: dev1-123456
  project_id          = "<PROJECT_ID>"
  # region example: asia-east1
  region              = "<REGION_ID>"
  # Optional for private ip console
  # Name of vpc network in which the management console was deployed
  vpc                 = ""
  # Optional for private ip console
  # IP CIDR range for the connector to above vpc
  # Example: 11.0.0.0/28
  ip_cidr_range_svpca = ""
  cpu                 = "2"
  memory              = "4096Mi"
  labels              = {
    name = "deepfence-cloud-scanner"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.21.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 4.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.21.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container"></a> [container](#module\_container) | ../../modules/services/container | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.container_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deepfence-key"></a> [deepfence-key](#input\_deepfence-key) | deepfence-key | `string` | `""` | no |
| <a name="input_mgmt-console-port"></a> [mgmt-console-port](#input\_mgmt-console-port) | mgmt-console-port | `string` | `"443"` | no |
| <a name="input_mgmt-console-url"></a> [mgmt-console-url](#input\_mgmt-console-url) | mgmt-console-url | `string` | `""` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | mode | `string` | `"service"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"deepfence-cloud-scanner"` | no |

## Outputs

No outputs.
