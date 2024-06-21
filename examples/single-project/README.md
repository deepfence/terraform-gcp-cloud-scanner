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
  version             = "0.5.0"
  name                = "deepfence-cloud-scanner"
  # mgmt-console-url: deepfence.customer.com or 22.33.44.55
  mgmt-console-url    = "<Console URL>"
  mgmt-console-port   = "443"
  deepfence-key       = "<Deepfence-key>"
  # ThreatMapper
  image_name          = "us-east1-docker.pkg.dev/deepfenceio/deepfence/cloud_scanner_ce:2.3.0"
  # ThreatStryker
  # image_name          = "us-east1-docker.pkg.dev/deepfenceio/deepfence/cloud_scanner:2.3.0"
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
| <a name="provider_google"></a> [google](#provider\_google) | 4.21.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container"></a> [container](#module\_container) | ../../modules/services/container | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.container_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Amount of CPU to reserve for cloud-scanner cloud run service | `string` | `"1"` | no |
| <a name="input_deepfence-key"></a> [deepfence-key](#input\_deepfence-key) | deepfence-key | `string` | `""` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Cloud Scanner docker image | `string` | `"us-east1-docker.pkg.dev/deepfenceio/deepfence/cloud_scanner_ce:2.3.0"` | no |
| <a name="input_ip_cidr_range_svpca"></a> [ip\_cidr\_range\_svpca](#input\_ip\_cidr\_range\_svpca) | IP CIDR Range for serverless vpc connector to be created for private ip console | `string` | `"11.0.0.0/28"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | <pre>{<br>  "name": "deepfence-cloud-scanner"<br>}</pre> | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level | `string` | `"info"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory to reserve for cloud-scanner cloud run service | `string` | `"2048Mi"` | no |
| <a name="input_mgmt-console-port"></a> [mgmt-console-port](#input\_mgmt-console-port) | mgmt-console-port | `string` | `"443"` | no |
| <a name="input_mgmt-console-url"></a> [mgmt-console-url](#input\_mgmt-console-url) | mgmt-console-url | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"deepfence-cloud-scanner"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC Network name if connecting to console via private ip | `string` | `""` | no |

## Outputs

No outputs.

