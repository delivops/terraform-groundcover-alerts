module "client_all_alerts" {
  source          = "delivops/alerts/groundcover"
  version         = "0.0.5"
  service_account = var.service_account
  client_name     = "deli"
  cluster_name    = "prod"
  folder_name     = "Alerts"
  slack_points    = ["xxxx"]
  email_points    = ["xxxx@gmail.com"]
  alerts = [
  { name = "High CPU Utilization in RDS", expr = "max by (name, namespace, node) (aws_rds_cpuutilization_maximum[5m]) > 7" },
  { name = "Low Freeable Memory in RDS", expr = "max by (name, namespace, node) (aws_rds_freeable_memory[5m]) < 20" },
  { name = "Node Status Check in RDS", expr = "max by (name, namespace, node) (aws_rds_node_status[5m]) != 1" }
]
}