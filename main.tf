terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3.7.0"
    }
  }
}
data "grafana_data_source" "prometheus" {
  name = var.cluster_name
}

locals {
  duration_multiplier = {
    "s" = 1
    "m" = 60
    "h" = 3600
    "d" = 86400
  }
  severity_map = {
    "error"    = "P1"
    "critical" = "P2"
    "warning"  = "P3"
    "info"     = "P4"
  }
}
