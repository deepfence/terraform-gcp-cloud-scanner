locals {
  suffix_org = var.is_organizational ? "org" : "single"
  task_env_vars = concat([
    # This allows the revision to be created again if the configuration changes.
    # Annotations can't be used or they can't be ignored in the lifecycle, thus triggering
    # recreations even if the config hasn't changed.
    {
      name  = "SECURE_URL"
      value = var.deepfence_secure_endpoint
    },
    {
      name  = "GCP_REGION"
      value = data.google_client_config.current.region
    }
    ], [
    for env_key, env_value in var.extra_envs :
    {
      name  = env_key,
      value = env_value
    }
    ]
  )
}


resource "google_cloud_run_service" "cloud_connector" {
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

        env {
          #TODO: Put secrets in secretsmanager?
          name  = "SECURE_API_TOKEN"
          value = var.deepfence_secure_api_token
        }

        dynamic "env" {
          for_each = toset(local.task_env_vars)

          content {
            name  = env.value.name
            value = env.value.value
          }
        }
      }
      service_account_name = var.cloud_connector_sa_email
    }
  }
}

resource "google_project_iam_member" "run_viewer" {
  project = var.project_id
  member  = "serviceAccount:${var.cloud_connector_sa_email}"
  role    = "roles/run.viewer"
}

