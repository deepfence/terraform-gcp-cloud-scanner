# Cloud Scanner in Google Cloud<br/>[ Example :: GKE-Cloud-Scanner ] 

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

# target cluster to deploy cloud scanner
data "google_container_cluster" "target_cluster" {
  name     = "<TARGET GKE CLUSTER NAME>"
  location = "<TARGET GKE CLUSTER NAME>"
  project  = "<PROJECT_ID>"
}

module "cloud-scanner_example_single_project" {
  source                     = "deepfence/cloud-scanner/gcp//examples/gke"
  version                    = "0.7.2"
  gke_host                   = "https://${data.google_container_cluster.target_cluster.endpoint}"
  gke_token                  = data.google_client_config.current.access_token
  gke_cluster_ca_certificate = base64decode(data.google_container_cluster.target_cluster.master_auth[0].cluster_ca_certificate,)
  name                       = "deepfence-cloud-scanner"
  # mgmt-console-url: deepfence.customer.com or 22.33.44.55
  mgmt-console-url           = "<Console URL>"
  deepfence-key              = "<Deepfence-key>"
  # quay.io/deepfenceio/cloud_scanner_ce if using ThreatMapper. quay.io/deepfenceio/cloud_scanner if using ThreatStryker
  image_name                 = "quay.io/deepfenceio/cloud_scanner_ce"
  image_tag                  = "2.3.1"
  # project_id example: dev1-123456
  project_id                 = "<PROJECT_ID>"
  # region example: asia-east1
  region                     = "<REGION_ID>"
  # target gke cluster to deploy cloud scanner
  cluster_name               = "<TARGET GKE CLUSTER NAME>"
  # target gke cluster location
  cluster_location           = "<TARGET GKE CLUSTER LOCATION>"
}
```

- For Organization Projects 
Copy the code below and paste it into a .tf file on your local machine.

```terraform

data "google_client_config" "current" {}

# target cluster to deploy cloud scanner
data "google_container_cluster" "target_cluster" {
  name     = "<TARGET GKE CLUSTER NAME>"
  location = "<TARGET GKE CLUSTER NAME>"
  project  = "<PROJECT_ID>"
}

module "cloud-scanner_example_multiple_project" {
  source                     = "deepfence/cloud-scanner/gcp//examples/gke"
  version                    = "0.7.2"
  name                       = "deepfence-cloud-scanner"
  gke_host                   = "https://${data.google_container_cluster.target_cluster.endpoint}"
  gke_token                  = data.google_client_config.current.access_token
  gke_cluster_ca_certificate = base64decode(data.google_container_cluster.target_cluster.master_auth[0].cluster_ca_certificate,)
  # mgmt-console-url: deepfence.customer.com or 22.33.44.55
  mgmt-console-url           = "<Console URL>"
  deepfence-key              = "<Deepfence-key>"
  # quay.io/deepfenceio/cloud_scanner_ce if using ThreatMapper. quay.io/deepfenceio/cloud_scanner if using ThreatStryker
  image_name                 = "quay.io/deepfenceio/cloud_scanner_ce"
  image_tag                  = "2.3.1"
  # project_id example: dev1-123456
  project_id                 = "<PROJECT_ID>"
  # region example: asia-east1
  region                     = "<REGION_ID>"
  # target gke cluster to deploy cloud scanner
  cluster_name               = "<TARGET GKE CLUSTER NAME>"
  # target gke cluster location
  cluster_location           = "<TARGET GKE CLUSTER NAME>"
  isOrganizationDeployment   = true
  # project id where the cloud scanner is deployed 
  deployedAccountID          = "<DEPLOYED PROJECT ID>"
  # organization project id 
  organizationAccountID      = "<ORG PROJECT ID>"
}
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 6.3.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 6.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_scanner_helm"></a> [cloud\_scanner\_helm](#module\_cloud\_scanner\_helm) | ../../modules/gke/cloud-scanner-helm | n/a |
| <a name="module_workload_identity"></a> [workload\_identity](#module\_workload\_identity) | ../../modules/gke/workload-identity | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.preexisting](https://registry.terraform.io/providers/hashicorp/google/6.3.0/docs/resources/service_account) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/6.3.0/docs/data-sources/client_config) | data source |
| [google_container_cluster.target_cluster](https://registry.terraform.io/providers/hashicorp/google/6.3.0/docs/data-sources/container_cluster) | data source |
| [google_projects.projects](https://registry.terraform.io/providers/hashicorp/google/6.3.0/docs/data-sources/projects) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_scanner_chart_name"></a> [cloud\_scanner\_chart\_name](#input\_cloud\_scanner\_chart\_name) | cloud scanner chart name | `string` | `"deepfence-cloud-scanner"` | no |
| <a name="input_cloud_scanner_chart_version"></a> [cloud\_scanner\_chart\_version](#input\_cloud\_scanner\_chart\_version) | cloud scanner chart version | `string` | `"2.3.1"` | no |
| <a name="input_cloud_scanner_image"></a> [cloud\_scanner\_image](#input\_cloud\_scanner\_image) | quay.io/deepfenceio/cloud\_scanner\_ce if using ThreatMapper. quay.io/deepfenceio/cloud\_scanner if using ThreatStryker | `string` | `"quay.io/deepfenceio/cloud_scanner_ce"` | no |
| <a name="input_cloud_scanner_image_tag"></a> [cloud\_scanner\_image\_tag](#input\_cloud\_scanner\_image\_tag) | cloud scanner container image tag | `string` | `"2.3.1"` | no |
| <a name="input_cloud_scanner_role"></a> [cloud\_scanner\_role](#input\_cloud\_scanner\_role) | cloud scanner role, it can be roles/iam.securityReviewer or roles/viewer | `string` | `"roles/iam.securityReviewer"` | no |
| <a name="input_cluster_location"></a> [cluster\_location](#input\_cluster\_location) | target cluster location/region | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | target cluster to install cloud scanner | `string` | n/a | yes |
| <a name="input_deepfence-key"></a> [deepfence-key](#input\_deepfence-key) | deepfence API key, Get it from console UI -> Settings -> User Management | `string` | n/a | yes |
| <a name="input_deployedAccountID"></a> [deployedAccountID](#input\_deployedAccountID) | target project where cloud scanner is deployed in org mode | `string` | `""` | no |
| <a name="input_extra_helm_values"></a> [extra\_helm\_values](#input\_extra\_helm\_values) | extra helm values for the helm chart uses same sytax as that of helm\_release for keys and values | `map(string)` | `{}` | no |
| <a name="input_isOrganizationDeployment"></a> [isOrganizationDeployment](#input\_isOrganizationDeployment) | n/a | `bool` | `false` | no |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | namespace to install deepfence cloud scanner | `string` | `"deepfence"` | no |
| <a name="input_k8s_service_account_name"></a> [k8s\_service\_account\_name](#input\_k8s\_service\_account\_name) | kubernetes service account name | `string` | `"deepfence-cloud-scanner"` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | cloud scanner log level | `string` | `"info"` | no |
| <a name="input_mgmt-console-port"></a> [mgmt-console-port](#input\_mgmt-console-port) | deepfence management console port | `string` | `"443"` | no |
| <a name="input_mgmt-console-url"></a> [mgmt-console-url](#input\_mgmt-console-url) | deepfence management clonsole url | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"deepfence-cloud-scanner"` | no |
| <a name="input_organizationAccountID"></a> [organizationAccountID](#input\_organizationAccountID) | organization project id | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | gcp project id | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->