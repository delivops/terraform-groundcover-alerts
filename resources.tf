resource "grafana_rule_group" "alerts" {
  count            = length(var.alerts) > 0 ? 1 : 0
  name             = var.rule_group_name
  folder_uid       = var.folder_uid
  interval_seconds = 60

  dynamic "rule" {
    for_each = var.alerts
    content {
      name           = rule.value.name
      condition      = "A"
      for            = "5m"
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
          expr          = rule.value.expr
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
        severity    = rule.value.severity
        og_priority = local.severity_map[rule.value.severity]
      }
      notification_settings {
        contact_point   = var.contact_point_name
        group_by        = ["alertname", "workload", "node", "namespace"]
        group_wait      = "45s"
        group_interval  = "6m"
        repeat_interval = "12h"
      }
    }
  }
}


