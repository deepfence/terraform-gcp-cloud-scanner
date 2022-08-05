# Cloud scanner for Google cloud by Deepfence

This module deploys Cloud scanner for Google cloud by creating underlying resources in Google cloud platform.

### Notice
**Deployment cost** - This example will create resources that cost money.<br/>Run `terraform destroy` when you don't need them anymore

## Prerequisites

1. Configure [Terraform **GCP** Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
1. Following **roles** are required in your GCP organization/project credentials
   * _Owner_
1. Besides, the following GCP **APIs must be enabled** to deploy resources correctly:

* [Identity and access management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)
* [Cloud Run API](https://console.cloud.google.com/marketplace/product/google/run.googleapis.com)


## Usage

### - Single-Project

Deepfence workload will be deployed in the same account where user's resources will be watched.

Please check out below to implement the same-
[`./examples/single-project`](examples/single-project)

## Authors

Module is maintained and supported by [Deepfence](https://deepfence.io/).

## License

Apache 2 Licensed. See LICENSE for full details.


