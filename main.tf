resource "google_cloud_run_service" "cloudrun" {
  project  = var.project_id
  name     = var.name
  provider = google-beta
  location = var.region

  template {
    spec {
      container_concurrency = var.concurrency
      timeout_seconds = var.timeout
      containers {
        image = "asia.gcr.io/wati-gke/whatsapp_inbox_server_mt:mt-dev"
        env {
          name = "AppSettings__DbName"
          value = "mt-dev-Tenants"
        }
        env {
          name = "AppSettings__PaymentApiHost"
          value = "https://mt-dev-client-wati-billing-service.clare.ai"
        }
        env {
          name = "AppSettings__TrialServer"
          value = "false"
        }
        env {
          name = "AppSettings__Hangfire"
          value = "mt-dev-Tenants"
        }
        env {
          name = "AppSettings__TwilioSmsWebhookUrl"
          value = "https://mt-dev-wati-be-7hnz7cqujq-as.a.run.app/api/v1/sms"
        }
        env {
          name = "AppSettings__FrontEndUrl"
          value = "https://mt-dev-wati-shared-chat-7hnz7cqujq-as.a.run.app"
        }
        env {
          name = "AppSettings__LoginUrl"
          value = "https://mt-dev-wati-shared-chat-7hnz7cqujq-as.a.run.app/login"
        }
        env {
          name = "AppSettings__rsPasswordUrl"
          value = "https://mt-dev-wati-shared-chat-7hnz7cqujq-as.a.run.app/resetpassword"
        }
        env {
          name = "MNT_DIR"
          value = "/app/wwwroot/data"
        }
        env {
          name = "DATA_DIR"
          value = "/app/wwwroot/data"
        }
        env {
          name = "CONFIG_DIR"
          value = "/app/config"
        }
        env {
          name = "FILESTORE_IP_ADDRESS"
          value = "10.212.244.2"
        }
        env {
          name = "NFS_DATA_DIR"
          value = "/watiapp_files/clients/${var.client_id}"
        }
        env {
          name = "NFS_CONFIG_DIR"
          value = "/watiapp_files/config"
        }
        env {
          name = "AppSettings__SecureRequestKey"
          value = "KiMQNk77vbcDiX"
        }
        env {
	  name = "MultiTenantDatabase__EnableHybrid"
          value = "false"
	}
        env {
          name = "MultiTenantDatabase__DbName"
          value = "mt-dev-Tenants"
        }
        env {
          name = "AppSettings__IsMultiTenantDatabase"
          value = "true"
        }
        env {
          name = "AppSettings__IsPricingPlanFeatureEnabled"
          value = "true"
        }
        env {
          name = "AppSettings__PricingApiHost"
          value = "https://dev-pricing-service-release-330-7hnz7cqujq-as.a.run.app"
        }
        env {
          name = "AppSettings__PricingApiKey"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "dev_PRICING_API_KEY"
            }
          }
        }
        env {
          name = "AppSettings__UseCustomMarkupFee"
          value = "true"
        }
        env {
          name = "AppSettings__IsMultiTenantBackend"
          value = "true"
        }
        env {
          name = "TenantIdResolverType"
          value = "path"
        }
        env {
          name = "AppSettings__EmailErrorAlert"
          value = "qa_errors_alert_dev_g-aaaagytyjl7gdiisyvzmntywty@clare-ai.slack.com"
        }
        env {
          name = "AppSettings__CustomerTimeZone"
          value = "+8"
        }
        env {
          name = "AppSettings__ClareSecretKey"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "dev_CLARE_SECRET_KEY"
            }
          }
        }
        env {
          name = "AppSettings__Mailgun-Key"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "dev_MAILGUN_API_KEY"
            }
          }
        }
        ports {
          container_port = var.port
        }

        resources {
            requests = {
                cpu = var.cpus
                memory = var.memory
            }
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = var.max_instances
        "autoscaling.knative.dev/minScale" = var.min_instances
        "run.googleapis.com/execution-environment" = var.execution_environment
        "run.googleapis.com/vpc-access-connector" = local.vpc_access.connector
        "run.googleapis.com/vpc-access-egress" = var.vpc_access_egress
	"run.googleapis.com/cpu-throttling"      = var.cpu_allocated ? false : true
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  #autogenerate_revision_name = true
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.cloudrun.location
  project     = google_cloud_run_service.cloudrun.project
  service     = google_cloud_run_service.cloudrun.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
