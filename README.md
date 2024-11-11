# terraform-groundcover-alerts
This Terraform module provisions alerts rules using Grafana for monitoring and notification purposes. The module allows you to create dynamic alerts based on various performance metrics of your resources and instances, helping you to proactively manage and respond to potential issues in your environment.

## Installation
To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage
The module will create Grafana alert rules for your environment. You can use this module multiple times to create alert rules with different configurations for various instances or metrics.

```python


################################################################################
# Groundcover Alert Rules
################################################################################


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
    { name = "Logs in App yace", string_attributes = ["level", "region"], severity = "warning", interval_in_minutes = "500", attributes_filters = { region : "%eu%", level : "info" }, workloads_filter = "yace-yet-another-cloudwatch-exporter%" },
    { name = "Logs in App 12", string_attributes = ["message", "level", "name"], severity = "warning", interval_in_minutes = "5", attributes_filters = { message : "error*", level : "high" }, workloads_filter = "workload1" }
  ]

}


```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | ~> 3.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | ~> 3.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_contact_point.combined](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/contact_point) | resource |
| [grafana_folder.alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder) | resource |
| [grafana_folder.logs_alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder) | resource |
| [grafana_rule_group.alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/rule_group) | resource |
| [grafana_rule_group.logs_alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/rule_group) | resource |
| [grafana_data_source.clickhouse](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/data_source) | data source |
| [grafana_data_source.prometheus](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/data_source) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts"></a> [alerts](#input\_alerts) | List of alert names and expressions | <pre>list(<br/>    object({<br/>      name     = string<br/>      expr     = string<br/>      severity = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Name of the client | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_email_points"></a> [email\_points](#input\_email\_points) | List of email addresses | `list(string)` | `[]` | no |
| <a name="input_folder_name"></a> [folder\_name](#input\_folder\_name) | Name of the Grafana folder | `string` | n/a | yes |
| <a name="input_logs_alerts"></a> [logs\_alerts](#input\_logs\_alerts) | List of log alert names and expressions | <pre>list(<br/>    object({<br/>      name                = string<br/>      string_attributes   = list(string)<br/>      severity            = string<br/>      interval_in_minutes = string<br/>      attributes_filters  = map(string)<br/>      workloads_filter    = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_opsgenie_points"></a> [opsgenie\_points](#input\_opsgenie\_points) | List of opsgenie API keys | `list(string)` | `[]` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account for the alerts | `string` | n/a | yes |
| <a name="input_slack_points"></a> [slack\_points](#input\_slack\_points) | List of Slack webhook URLs | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_contact_point_name"></a> [contact\_point\_name](#output\_contact\_point\_name) | Name of the created contact point |
<!-- END_TF_DOCS -->

## information

1. Time to create a alert-rules is around 5 minutes.

## License

MIT
