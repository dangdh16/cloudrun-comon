project_id = "wati-gke"
region = "asia-southeast1"
port = 80
timeout = 60
max_instances = 50
min_instances = 1
ingress = "all"
vpc_access_egress = "private-ranges-only"
vpc_connector_name = "filestore-connector"
execution_environment = "gen2"
name = "mt-dev-wati-be"
client_id = 999999999
cpu_allocated = true
