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
  version         = "0.0.15"
  service_account = "xxx"
  cluster_name    = "prod"
  folder_uid      = "xxx"
  rule_group_name = "Groundcover Alerts"
  contact_point_name = "OpsGenie"
  alerts = [
    { name = "Out of sync applications in ArgoCD", expr = "count by(name, node, namespace) (rate(argocd_app_info{sync_status=\"OutOfSync\"}[1m])) > 0", severity = "warning" },
    { name = "High CPU Utilization in RDS", expr = "max by (name, namespace, node) (aws_rds_cpuutilization_maximum[5m]) > 7", severity = "warning" },
    { name = "Low Freeable Memory in RDS", expr = "max by (name, namespace, node) (aws_rds_freeable_memory[5m]) < 20", severity = "warning" },
    { name = "Node Status Check in RDS", expr = "max by (name, namespace, node) (aws_rds_node_status[5m]) != 1", severity = "warning" }

  ]
}


```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                               | Version  |
| ------------------------------------------------------------------ | -------- |
| <a name="requirement_grafana"></a> [grafana](#requirement_grafana) | >= 3.7.0 |

## Providers

| Name                                                         | Version  |
| ------------------------------------------------------------ | -------- |
| <a name="provider_grafana"></a> [grafana](#provider_grafana) | >= 3.7.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                           | Type        |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [grafana_contact_point.combined](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/contact_point)  | resource    |
| [grafana_folder.alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder)                  | resource    |
| [grafana_folder.logs_alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder)             | resource    |
| [grafana_rule_group.alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/rule_group)          | resource    |
| [grafana_rule_group.logs_alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/rule_group)     | resource    |
| [grafana_data_source.clickhouse](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/data_source) | data source |
| [grafana_data_source.prometheus](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/data_source) | data source |

## Inputs

| Name                                                                           | Description                             | Type                                                                                                                                                                                                                                 | Default | Required |
| ------------------------------------------------------------------------------ | --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | :------: |
| <a name="input_alerts"></a> [alerts](#input_alerts)                            | List of alert names and expressions     | <pre>list(<br/> object({<br/> name = string<br/> expr = string<br/> severity = string<br/> })<br/> )</pre>                                                                                                                           | n/a     |   yes    |
| <a name="input_client_name"></a> [client_name](#input_client_name)             | Name of the client                      | `string`                                                                                                                                                                                                                             | n/a     |   yes    |
| <a name="input_cluster_name"></a> [cluster_name](#input_cluster_name)          | Name of the cluster                     | `string`                                                                                                                                                                                                                             | n/a     |   yes    |
| <a name="input_email_points"></a> [email_points](#input_email_points)          | List of email addresses                 | `list(string)`                                                                                                                                                                                                                       | `[]`    |    no    |
| <a name="input_folder_name"></a> [folder_name](#input_folder_name)             | Name of the Grafana folder              | `string`                                                                                                                                                                                                                             | n/a     |   yes    |
| <a name="input_logs_alerts"></a> [logs_alerts](#input_logs_alerts)             | List of log alert names and expressions | <pre>list(<br/> object({<br/> name = string<br/> string_attributes = list(string)<br/> severity = string<br/> interval_in_minutes = string<br/> attributes_filters = map(string)<br/> workloads_filter = string<br/> })<br/> )</pre> | n/a     |   yes    |
| <a name="input_opsgenie_points"></a> [opsgenie_points](#input_opsgenie_points) | List of opsgenie API keys               | `list(string)`                                                                                                                                                                                                                       | `[]`    |    no    |
| <a name="input_service_account"></a> [service_account](#input_service_account) | Service account for the alerts          | `string`                                                                                                                                                                                                                             | n/a     |   yes    |
| <a name="input_slack_points"></a> [slack_points](#input_slack_points)          | List of Slack webhook URLs              | `list(string)`                                                                                                                                                                                                                       | `[]`    |    no    |

## Outputs

| Name                                                                                      | Description                       |
| ----------------------------------------------------------------------------------------- | --------------------------------- |
| <a name="output_contact_point_name"></a> [contact_point_name](#output_contact_point_name) | Name of the created contact point |

<!-- END_TF_DOCS -->

## information

1. Time to create a alert-rules is around 5 minutes.

## License

MIT
