
resource "grafana_folder" "rds_alerts" {
  title = var.folder_name
}
resource "grafana_rule_group" "rds_alerts" {
  name             = "rds-alerts"
  folder_uid       = grafana_folder.rds_alerts.uid
  interval_seconds = 60

  dynamic "rule" {
    for_each = var.alerts
    content {
      name           = "K8S RDS Instance ${upper(rule.value.type)} Alert"
      condition      = "A"
      for            = "10m"
      no_data_state  = "OK"
      exec_err_state = "OK"

      data {
        ref_id = "A"
        relative_time_range {
          from = 600
          to   = 0
        }
        datasource_uid = data.grafana_data_source.prometheus.uid
        model = jsonencode({
          datasource = {
            type = "prometheus"
            uid  = data.grafana_data_source.prometheus.uid
          }
          editorMode    = "code"
          expr          = replace(local.alert_expressions[rule.value.type], "$${threshold}", rule.value.threshold)
          instant       = true
          intervalMs    = 1000
          legendFormat  = "__auto"
          maxDataPoints = 43200
          range         = false
          refId         = "A"
        })
      }

      annotations = {}

      labels = {
        workload    = "{{ $labels.name }}"
        severity    = rule.value.severity
        og_priority = local.severity_to_priority[rule.value.severity]
        namespace   = "{{ $labels.namespace }}"
        node        = ""
      }
    }
  }
}
