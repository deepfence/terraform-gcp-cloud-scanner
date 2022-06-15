# Cloud compliance scanner
This module deploys the cloud compliance scanner in cloud run container with read only access to cloud resources. It also creates the invoker access to invoke the container.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.21.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service.container](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_member.run_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_project_iam_member.run_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_sa_email"></a> [container\_sa\_email](#input\_container\_sa\_email) | Container service account email | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Amount of CPU to reserve for cloud-connector cloud run service | `string` | `"1"` | no |
| <a name="input_deepfence-key"></a> [deepfence-key](#input\_deepfence-key) | deepfence-key | `string` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Deepfence cloud compliance scanner image. GCP only allows the deployment of images that are registered in gcr.io | `string` | `"us-docker.pkg.dev/cloudrun/container/hello"` | no |
| <a name="input_max_instances"></a> [max\_instances](#input\_max\_instances) | Max number of instances for the Cloud Connector | `number` | `1` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory to reserve for cloud-connector cloud run service | `string` | `"2048Mi"` | no |
| <a name="input_mgmt-console-port"></a> [mgmt-console-port](#input\_mgmt-console-port) | mgmt-console-port | `string` | n/a | yes |
| <a name="input_mgmt-console-url"></a> [mgmt-console-url](#input\_mgmt-console-url) | mgmt-console-url | `string` | n/a | yes |
| <a name="input_mode"></a> [mode](#input\_mode) | mode | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"cloud-compliance-scanner-cloudconnector"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | organizational member project ID where the workload is going to be deployed | `string` | n/a | yes |

## Outputs

No outputs.
