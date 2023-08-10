variable "project_id" {
  type = string
  description = "The project ID to host the cluster in"
}

variable "region" {
  type = string  
  default = "asia-southeast1"
  description = "The region to host the cluster in"
}

variable "name" {
  type = string
  description = "Name of CloudRun service"
}

variable concurrency {
  type = number
  default = 200
  description = "The maximum number of concurrent requests that can reach each container instance."
}

variable cpus {
  type = string
  default = "1000m"
  description = "Number of CPUs to allocate per container."
}

variable memory {
  type = string
  default = "512M"
  description = "Memory (in Mi) to allocate to containers. Minimum of 512Mi is required when `execution_environment` is `\"gen2\"`."
}

variable port {
  type = number
  default = 8080
  description = "Port on which the container is listening for incoming HTTP requests."
}

variable max_instances {
  type = number
  default = 1000
  description = "Maximum number of container instances allowed to start."
}

variable min_instances {
  type = number
  default = 0
  description = "Minimum number of container instances to keep running."
}

variable allow_public_access {
  type = bool
  default = true
  description = "Allow unauthenticated access to the service."
}

variable timeout {
  type = number
  default = 60
  description = "The maximum number of concurrent requests that can reach each container instance."
}

variable execution_environment {
  type = string
  default = "gen1"
  description = "Execution environment to run container instances under."
}


variable vpc_connector_name {
  type = string
  default = null
  description = "VPC connector to apply to this service (Deprecated - use `var.vpc_access.connector` instead)."
}

variable vpc_access_egress {
  type = string
  default = "private-ranges-only"
  description = "Specify whether to divert all outbound traffic through the VPC, or private ranges only (Deprecated - use `var.vpc_access.egress` instead)."
}

variable ingress {
  type = string
  default = "all"
  description = "Ingress settings for the service. Allowed values: [`\"all\"`, `\"internal\"`, `\"internal-and-cloud-load-balancing\"`]"
}

variable client_id {
  type = string
  default = "999999999"
  description = "client_id"
}

variable image {
  type = string
  default = "asia.gcr.io/wati-gke/whatsapp_inbox_server:support_dev_mt"
  description = "image"
}


variable image_version {
  type = string
  default = "01"
  description = "image"
}

variable cpu_allocated {
  type = bool
  default = true
  description = "true is enable cpu allocated"
}

variable envs {
  type = list(object{
    name  = string,
    value = string
  })
  default = []
  description = "Environment of applications"
}

variable envs_secret {
  type = list(object{
    name = string,
    value_from = {
        secret_key_ref = {
            key  = string,
            name = string
        }
    }
  })
  default = []
  description = "Environment get from secret of applications"
}