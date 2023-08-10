resource "google_cloud_run_v2_service" "cloudrun" {
  project  = var.project_id
  name     = var.name
  provider = google-beta
  location = var.region

  template {
    # container_concurrency = var.concurrency
    # timeout_seconds = var.timeout
    containers {
      image = "asia.gcr.io/wati-gke/whatsapp_inbox_server_mt:mt-dev"
      dynamic "env" {
        for_each = var.envs
        content {
          name = env.value.name
          value = env.value.value
        }
      }
      dynamic "env" {
        for_each = var.envs_secret
        content {
          name = env.value.name
          dynamic "value_source" {
            for_each = [1]
            content {
              dynamic "secret_key_ref" {
                for_each = [1]
                content {
                  secret = env.value.value_from.secret_key_ref.secret
                  version = env.value.value_from.secret_key_ref.version
                }
              }
            }
          }
        }
      }
      ports {
        container_port = var.port
      }
      resources {
        cpu_idle = var.cpu_allocated ? false : true
        #requests = {
        #  cpu = var.cpus
        #  memory = var.memory
        #}
      }
    }
    vpc_access{
      connector = var.vpc_connector_name
      egress = var.vpc_access_egress
    }
    annotations = {
      "autoscaling.knative.dev/maxScale" = var.max_instances
      "autoscaling.knative.dev/minScale" = var.min_instances
      "run.googleapis.com/execution-environment" = var.execution_environment
    }
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_v2_service.cloudrun.location
  project     = google_cloud_run_v2_service.cloudrun.project
  service     = google_cloud_run_v2_service.cloudrun.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
