resource "grafana_folder" "alerts" {
  count = length(var.alerts) > 0 ? 1 : 0
  title = var.folder_name
}
resource "grafana_folder" "logs_alerts" {
  count = length(var.logs_alerts) > 0 ? 1 : 0
  title = "${var.folder_name}_logs"
}

resource "grafana_contact_point" "combined" {
  name = "${var.client_name}_${var.cluster_name}_contact_point"
  dynamic "slack" {
    for_each = var.slack_points
    content {
      icon_emoji              = ":fire:"
      url                     = slack.value
      disable_resolve_message = true
      title                   = " :fire: {{ .CommonLabels.alertname }}"
      text                    = "{{ len .Alerts }} instances\n {{ range .Alerts }}{{ if or .Labels.pod .Labels.pod_name .Labels.entity_name .Labels.name  }}*Name:* {{ or .Labels.pod .Labels.pod_name .Labels.entity_name .Labels.name  }}\n *Value:* {{ $value }}\n *Value:* {{ .Labels.Value }}\n\n{{ end }}{{ end }}"
    }
  }
  #{{ if .CommonLabels.namespace }} on: {{ .CommonLabels.namespace }}{{ end }}{{ if .CommonLabels.node }} node: {{ .CommonLabels.node }}{{ end }}{{ if .CommonLabels.workload }}/{{ .CommonLabels.workload }}{{ end }}"
  dynamic "opsgenie" {
    for_each = var.opsgenie_points
    content {
      api_key           = opsgenie.value
      url               = "https://api.opsgenie.com/v2/alerts"
      description       = "${var.client_name} :fire: {{ len .Alerts }} {{ .CommonLabels.alertname }}{{ if .CommonLabels.namespace }} on: {{ .CommonLabels.namespace }}{{ end }}{{ if .CommonLabels.node }} node: {{ .CommonLabels.node }}{{ end }}{{ if .CommonLabels.workload }}/{{ .CommonLabels.workload }}{{ end }}"
      send_tags_as      = "tags"
      override_priority = true
    }
  }
  dynamic "email" {
    for_each = var.email_points
    content {
      addresses = [email.value]
    }
  }
  lifecycle {
    ignore_changes = [slack, opsgenie, email]
  }
}
resource "grafana_rule_group" "alerts" {
  count            = length(var.alerts) > 0 ? 1 : 0
  name             = "${var.client_name}_${var.cluster_name}_alerts"
  folder_uid       = grafana_folder.alerts[0].uid
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
        contact_point   = grafana_contact_point.combined.name
        group_by        = ["alertname", "workload", "node", "namespace"]
        group_wait      = "45s"
        group_interval  = "6m"
        repeat_interval = "12h"
      }
    }
  }
}
resource "grafana_rule_group" "logs_alerts" {
  count            = length(var.logs_alerts) > 0 ? 1 : 0
  name             = "${var.client_name}_${var.cluster_name}_logs_alerts"
  folder_uid       = grafana_folder.logs_alerts[0].uid
  interval_seconds = 60

  dynamic "rule" {
    for_each = var.logs_alerts
    content {
      name           = rule.value.name
      condition      = "A"
      for            = "${rule.value.interval_in_minutes}m"
      no_data_state  = "OK"
      exec_err_state = "OK"

      data {
        ref_id = "A"
        relative_time_range {
          from = 600
          to   = 0
        }
        datasource_uid = data.grafana_data_source.clickhouse.uid
        model = jsonencode({
          datasource = {
            type = "clickhouse"
            uid  = data.grafana_data_source.clickhouse.uid
          }
          editorType = "sql"
          format     = 1
          intervalMs = 1000
          query_type = "table"
          rawSql = <<-EOT
SELECT 
  count(*) as errors,
  ${join(", ", [for attr in rule.value.string_attributes : "string_attributes['${attr}'] as ${attr}"])}
FROM logs
WHERE $__timeFilter(timestamp) 
  ${rule.value.workloads_filter != "" ? "and (workload='${rule.value.workloads_filter}')" : ""}
  ${length(rule.value.attributes_filters) > 0 ? format("and %s", join(" and ", [
          for k, v in rule.value.attributes_filters :
          "string_attributes['${k}'] LIKE '${v}'"
    ])) : ""}
GROUP BY ${join(", ", [for attr in rule.value.string_attributes : "string_attributes['${attr}']"])}
EOT
})
query_type = "table"
}
annotations = {}
labels = {
  severity    = rule.value.severity
  og_priority = local.severity_map[rule.value.severity]
}
notification_settings {
  contact_point   = grafana_contact_point.combined.name
  group_by        = ["workloads_filter"]
  group_wait      = "45s"
  group_interval  = "6m"
  repeat_interval = "12h"
}
}
}
}

