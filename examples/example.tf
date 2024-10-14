
module "all_alerts" {
  source          = "delivops/alerts/groundcover"
  version         = "0.0.7"
  service_account = "xxx"
  client_name     = "delivops"
  cluster_name    = "prod"
  folder_name     = "Alerts"
  opsgenie_points = ["xxx"]
  slack_points    = ["xxx"]
  email_points    = ["osnat@gmail.com"]
  alerts = [
    { name = "Out of sync applications in ArgoCD", expr = "count by(name, node, namespace) (rate(argocd_app_info{sync_status=\"OutOfSync\"}[1m])) > 0", severity = "warning" },
    { name = "High CPU Utilization in RDS", expr = "max by (name, namespace, node) (aws_rds_cpuutilization_maximum[5m]) > 7", severity = "warning" },
    { name = "Low Freeable Memory in RDS", expr = "max by (name, namespace, node) (aws_rds_freeable_memory[5m]) < 20", severity = "warning" },
    { name = "Node Status Check in RDS", expr = "max by (name, namespace, node) (aws_rds_node_status[5m]) != 1", severity = "warning" }

  ]
  logs_alerts = [
    { name = "Logs in App yace", string_attributes = ["level", "region"], severity = "warning", interval_in_minutes = "500", regex_attribute = { region : "%eu%", level : "info" }, workload = "yace-yet-another-cloudwatch-exporter" },
    { name = "Logs in App 12", string_attributes = ["message", "level", "name"], severity = "warning", interval_in_minutes = "5", regex_attribute = { message : "error*", level : "high" }, workload = "workload1" }
  ]
}

