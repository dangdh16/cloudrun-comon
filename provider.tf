terraform {
  required_version = ">= 1.0"
  backend "gcs" {
    bucket  = "terraform-cloudrun"
    prefix  = "mt-tfstate-wati-be-dev"
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}
