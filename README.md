<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | ~> 3.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | ~> 3.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_folder.rds_alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder) | resource |
| [grafana_rule_group.rds_alerts](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/rule_group) | resource |
| [grafana_data_source.prometheus](https://registry.terraform.io/providers/grafana/grafana/latest/docs/data-sources/data_source) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts"></a> [alerts](#input\_alerts) | List of alert configurations | <pre>list(object({<br/>    type      = string<br/>    threshold = number<br/>    severity  = string<br/>    contact   = string<br/>  }))</pre> | n/a | yes |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | client\_name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | cluster name | `string` | n/a | yes |
| <a name="input_contact_point_name"></a> [contact\_point\_name](#input\_contact\_point\_name) | contact\_point\_name | `string` | `"opsgenie"` | no |
| <a name="input_folder_name"></a> [folder\_name](#input\_folder\_name) | folder name | `string` | `"custom alerts"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | generated service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_folder_uid"></a> [folder\_uid](#output\_folder\_uid) | UID of the created Grafana folder |
| <a name="output_rule_group_id"></a> [rule\_group\_id](#output\_rule\_group\_id) | ID of the created rule group |
<!-- END_TF_DOCS -->