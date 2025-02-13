provider "grafana" {
  url  = var.grafana_url
  auth = var.service_account

}