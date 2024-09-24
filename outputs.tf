output "folder_uid" {
  description = "UID of the created Grafana folder"
  value       = grafana_folder.alerts.uid
}

output "rule_group_id" {
  description = "ID of the created rule group"
  value       = grafana_rule_group.alerts.id
}

output "contact_point_name" {
  description = "Name of the created contact point"
  value       = grafana_contact_point.combined.name
}