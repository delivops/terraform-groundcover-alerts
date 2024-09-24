# terraform-aws-rds-alerts
This Terraform module provisions AWS RDS alert rules using Grafana for monitoring and notification purposes. The module allows you to create dynamic alerts based on various performance metrics of your RDS instances, helping you to proactively manage and respond to potential issues in your database environment.

## Installation
To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage
The module will create Grafana alert rules for AWS RDS instances. You can use this module multiple times to create alert rules with different configurations for various RDS instances or metrics.

```python


################################################################################
# Groundcover RDS alert rules
################################################################################


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


```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## information

1. Time to create a rds-alert-rules is around 2 minutes.

## License

MIT