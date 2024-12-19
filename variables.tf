variable "service_account" {
  description = "Service account for the alerts"
  type        = string
}

variable "rule_group_name" {
  description = "Name of the rule group"
  type        = string

}
variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "folder_uid" {
  description = "Uid of the Grafana folder"
  type        = string
}
variable "contact_point_name" {
  description = "Name of the contact point"
  type        = string

}
variable "alerts" {
  description = "List of alert names and expressions"
  type = list(
    object({
      name     = string
      expr     = string
      severity = string
    })
  )
}

