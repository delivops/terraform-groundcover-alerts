
module "all_alerts" {
  source             = "delivops/alerts/groundcover"
  version            = "0.0.15"
  service_account    = "xxx"
  cluster_name       = "prod"
  folder_uid         = "xxx"
  rule_group_name    = "Groundcover Alerts"
  contact_point_name = "OpsGenie"
  alerts = [
    { name = "Out of sync applications in ArgoCD", expr = "count by(name, node, namespace) (rate(argocd_app_info{sync_status=\"OutOfSync\"}[1m])) > 0", severity = "warning" },
    { name = "High CPU Utilization in RDS", expr = "max by (name, namespace, node) (aws_rds_cpuutilization_maximum[5m]) > 7", severity = "warning" },
    { name = "Low Freeable Memory in RDS", expr = "max by (name, namespace, node) (aws_rds_freeable_memory[5m]) < 20", severity = "warning" },
    { name = "Node Status Check in RDS", expr = "max by (name, namespace, node) (aws_rds_node_status[5m]) != 1", severity = "warning" }

  ]
}

