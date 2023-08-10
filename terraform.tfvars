project_id = "wati-gke"
region = "asia-southeast1"
port = 80
timeout = 60
max_instances = 50
min_instances = 1
ingress = "all"
vpc_access_egress = "PRIVATE_RANGES_ONLY"
vpc_connector_name = "filestore-connector"
execution_environment = "gen2"
name = "mt-dev-wati-be"
client_id = 999999999
cpu_allocated = true

envs = [
    {
        name = "AppSettings__DbName",
        value = "mt-dev-Tenants"
    },
    {
        name = "AppSettings__PaymentApiHost",
        value = "https://mt-dev-client-wati-billing-service.clare.ai"
    },
    {
        name = "AppSettings__TrialServer",
        value = "false"
    },
    {
        name = "AppSettings__Hangfire",
        value = "mt-dev-Tenants"
    },
    {
      name  = "AppSettings__TwilioSmsWebhookUrl",
      value = "https://mt-dev-wati-be-7hnz7cqujq-as.a.run.app/api/v1/sms"
    },
    {
      name  = "AppSettings__FrontEndUrl",
      value = "https://mt-dev-wati-shared-chat-7hnz7cqujq-as.a.run.app"
    },
    {
      name  = "AppSettings__LoginUrl",
      value = "https://mt-dev-wati-shared-chat-7hnz7cqujq-as.a.run.app/login"
    },
    {
      name  = "AppSettings__rsPasswordUrl",
      value = "https://mt-dev-wati-shared-chat-7hnz7cqujq-as.a.run.app/resetpassword"
    },
    {
      name  = "MNT_DIR",
      value = "/app/wwwroot/data"
    },
    {
      name  = "DATA_DIR",
      value = "/app/wwwroot/data"
    },
    {
      name  = "CONFIG_DIR",
      value = "/app/config"
    },
    {
      name  = "FILESTORE_IP_ADDRESS",
      value = "10.212.244.2"
    },
    {
      name  = "NFS_DATA_DIR",
      value = "/watiapp_files/clients/999999999"
    },
    {
      name  = "NFS_CONFIG_DIR",
      value = "/watiapp_files/config"
    },
    {
      name  = "AppSettings__SecureRequestKey",
      value = "KiMQNk77vbcDiX"
    },
    {
      name  = "MultiTenantDatabase__EnableHybrid",
      value = "false"
    },
    {
      name  = "MultiTenantDatabase__DbName",
      value = "mt-dev-Tenants"
    },
    {
      name  = "AppSettings__IsMultiTenantDatabase",
      value = "true"
    },
    {
      name  = "AppSettings__IsPricingPlanFeatureEnabled",
      value = "true"
    },
    {
        name = "AppSettings__PricingApiHost",
        value = "https://dev-pricing-service-release-330-7hnz7cqujq-as.a.run.app"
    },
    {
      name  = "AppSettings__UseCustomMarkupFee",
      value = "true"
    },
    {
      name  = "AppSettings__IsMultiTenantBackend",
      value = "true"
    },
    {
      name  = "TenantIdResolverType",
      value = "path"
    },
    {
      name  = "AppSettings__EmailErrorAlert",
      value = "qa_errors_alert_dev_g-aaaagytyjl7gdiisyvzmntywty@clare-ai.slack.com"
    },
    {
      name  = "AppSettings__CustomerTimeZone",
      value = "+8"
    },
]
envs_secret = {
    SECRET_1 = {
        name = "AppSettings__PricingApiKey",
        value_source = {
            secret_key_ref = {
                version  = "1",
                secret = "dev_PRICING_API_KEY"
            }
        }
    },
    SECRET_2 = {
        name = "AppSettings__ClareSecretKey",
        value_source = {
            secret_key_ref = {
                version  = "1",
                secret = "dev_CLARE_SECRET_KEY"
            }
        }
    },
    SECRET_3 = {
        name = "AppSettings__Mailgun-Key",
        value_source = {
            secret_key_ref = {
                version  = "1",
                secret = "dev_MAILGUN_API_KEY"
            }
        }
    }
}