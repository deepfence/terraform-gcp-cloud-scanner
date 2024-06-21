# defining container env variables

locals {
  task_env_vars = concat([
    # This allows the revision to be created again if the configuration changes.
    # Annotations can't be used or they can't be ignored in the lifecycle, thus triggering
    # recreations even if the config hasn't changed.
    {
      name  = "CLOUDSDK_CORE_PROJECT"
      value = var.project_id
    },
    {
      name  = "CLOUD_REGION"
      value = var.location
    },
    {
      name  = "CLOUD_ACCOUNT_ID"
      value = var.project_id
    },
    {
      name  = "MGMT_CONSOLE_URL"
      value = var.mgmt-console-url
    },
    {
      name  = "MGMT_CONSOLE_PORT"
      value = var.mgmt-console-port
    },
    {
      name  = "DEEPFENCE_KEY"
      value = var.deepfence-key
    },
    {
      name  = "CLOUD_PROVIDER"
      value = "gcp"
    },
    {
      name  = "ORGANIZATION_DEPLOYMENT"
      value = tostring(var.is_organizational)
    },
    {
      name  = "HTTP_SERVER_REQUIRED"
      value = "true"
    },
    {
      name  = "LOG_LEVEL"
      value = var.log_level
    },
    {
      name  = "SCAN_INACTIVE_THRESHOLD"
      value = "21600"
    },
  ]
  )
}

# VPC access to private ip
resource "google_vpc_access_connector" "accessors" {
  count          = var.vpc != "" ? 1 : 0
  name           = var.name
  region         = var.location
  project        = var.project_id
  network        = var.vpc
  ip_cidr_range  = var.ip_cidr_range_svpca
  min_throughput = 200
  max_throughput = 300
}
# deploys application image in cloud run container

resource "google_cloud_run_service" "container" {
  location = var.location
  name     = var.name
  project  = var.project_id
  lifecycle {
    # We ignore changes in some annotations Cloud Run adds to the resource so we can
    # avoid unwanted recreations.
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels,
      template[0].metadata[0].annotations,
      template[0].spec[0].containers[0].ports[0].name
    ]
  }

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "internal"
    }
    labels = var.labels
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = tostring(var.max_instances)
        "autoscaling.knative.dev/minScale"        = tostring(var.min_instances)
        "run.googleapis.com/cpu-throttling"       = "false"
        "run.googleapis.com/vpc-access-connector" = var.vpc != "" ? google_vpc_access_connector.accessors[0].name : ""
        "run.googleapis.com/vpc-access-egress"    = var.vpc != "" ? "all-traffic" : null
      }
    }

    spec {
      containers {
        image = var.image_name
        resources {
          limits = {
            cpu    = var.cpu,
            memory = var.memory,
          }
        }

        ports {
          container_port = 8080
        }

        dynamic "env" {
          for_each = toset(local.task_env_vars)
          content {
            name  = env.value.name
            value = env.value.value
          }
        }
      }
      service_account_name = var.container_sa_email
    }
  }
}

# assigns cloud run service invoker role

resource "google_cloud_run_service_iam_member" "run_invoker" {
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.container_sa_email}"
  service  = google_cloud_run_service.container.name
  project  = google_cloud_run_service.container.project
  location = google_cloud_run_service.container.location
}

# assigns read only resource access on cloud

resource "google_project_iam_member" "project_iam_member" {
  for_each = toset(data.google_projects.projects.projects.*.project_id)

  project = each.value
  role    = "roles/iam.securityReviewer"
  member  = "serviceAccount:${var.container_sa_email}"
}
