terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 3.7.0"
    }
  }
}
data "grafana_data_source" "prometheus" {
  name = format("Prometheus@%s", var.cluster_name)
}
locals {
  duration_multiplier = {
    "s" = 1
    "m" = 60
    "h" = 3600
    "d" = 86400
  }

  alert_expressions = {
    cpu    = "max by (name,namespace, node) (aws_rds_cpuutilization_maximum[5m]) > $${threshold}"
    memory = "max by (name,namespace, node) (aws_rds_freeable_memory[5m]) < $${threshold}"
    node   = "max by (name,namespace, node) (aws_rds_node_status[5m]) != 1"
  }
  severity_to_priority = {
    critical = "P1"
    warning  = "P2"
    info     = "P3"
  }
}
