# terraform-aws-rds-alerts
This Terraform module provisions alerts rules using Grafana for monitoring and notification purposes. The module allows you to create dynamic alerts based on various performance metrics of your resources and instances, helping you to proactively manage and respond to potential issues in your environment.

## Installation
To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage
The module will create Grafana alert rules for your environment. You can use this module multiple times to create alert rules with different configurations for various instances or metrics.

```python


################################################################################
# Groundcover Alert Rules
################################################################################


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


```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## information

1. Time to create a rds-alert-rules is around 2 minutes.

## License

MIT