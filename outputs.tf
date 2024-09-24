output "folder_uid" {
  description = "UID of the created Grafana folder"
  value       = grafana_folder.rds_alerts.uid
}

output "rule_group_id" {
  description = "ID of the created rule group"
  value       = grafana_rule_group.rds_alerts.id
}
