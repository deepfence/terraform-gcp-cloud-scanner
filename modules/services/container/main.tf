# defining container env variables

locals {
  task_env_vars = concat([
    # This allows the revision to be created again if the configuration changes.
    # Annotations can't be used or they can't be ignored in the lifecycle, thus triggering
    # recreations even if the config hasn't changed.
    {
      name  = "CLOUD_PROVIDER"
      value = var.cloud_provider
    },
    {
      name  = "CLOUD_ACCOUNT_ID"
      value = var.project_id
    },
    {
      name  = "CLOUDSDK_CORE_PROJECT"
      value = var.project_id
    },
    {
      name  = "GCP_REGION"
      value = data.google_client_config.current.region
    }

    ]
  )
}

# deploys application image in cloud run container

resource "google_cloud_run_service" "container" {
  location = data.google_client_config.current.region
  name     = var.name

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
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = tostring(var.max_instances)
        "autoscaling.knative.dev/minScale" = tostring(var.min_instances)
        "run.googleapis.com/cpu-throttling" = "false"
      }
    }

    spec {
      containers {
        image = var.image_name
        command = ["/usr/local/bin/cloud_compliance_scan", "-mode", var.mode, "-mgmt-console-url", var.mgmt-console-url, "-mgmt-console-port", var.mgmt-console-port, "-deepfence-key", var.deepfence-key, "-http-server-required", "true"]
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

resource "google_project_iam_member" "run_viewer" {
  project = var.project_id
  member  = "serviceAccount:${var.container_sa_email}"
  role    = "roles/run.viewer"
}

