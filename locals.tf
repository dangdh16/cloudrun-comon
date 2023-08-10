locals {
  project = var.project_id
  vpc_access = {
    connector = var.vpc_connector_name
    egress = var.vpc_access_egress
  }
}

data "google_secret_manager_secret" "dev-clare-secret-key" {
  secret_id = "dev_CLARE_SECRET_KEY"
}

data "google_secret_manager_secret" "dev-mailgun-api-key" {
  secret_id = "dev_MAILGUN_API_KEY"
}
