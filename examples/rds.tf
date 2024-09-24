module "delivops_rds_alerts" {
  source          = "delivops/rds-alerts/groundcover"
  version         = "0.0.2"
  service_account = var.service_account
  client_name     = "client1"
  cluster_name    = "production"
  folder_name     = "RDS Alerts"

  alerts = [
    {
      type      = "cpu"
      threshold = 30
      severity  = "warning"
      contact   = "alerting_contact_points"
    },
    {
      type      = "memory"
      threshold = 1000000000 # 1GB in bytes
      severity  = "critical"
      contact   = "alerting_contact_points"
    },
    {
      type      = "node"
      threshold = 1
      severity  = "critical"
      contact   = "alerting_contact_points"
    }
  ]
}