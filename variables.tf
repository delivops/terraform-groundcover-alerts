variable "service_account" {
  description = "Service account for the alerts"
  type        = string
}

variable "client_name" {
  description = "Name of the client"
  type        = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "folder_name" {
  description = "Name of the Grafana folder"
  type        = string
}

variable "slack_points" {
  description = "List of Slack webhook URLs"
  type        = list(string)
  default     = []
}
variable "opsgenie_points" {
  description = "List of opsgenie API keys"
  type        = list(string)
  default     = []
}

variable "email_points" {
  description = "List of email addresses"
  type        = list(string)
  default     = []
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
variable "logs_alerts" {
  description = "List of log alert names and expressions"
  type = list(
    object({
      name                = string
      string_attributes   = list(string)
      severity            = string
      interval_in_minutes = string
      regex_attribute     = map(string)
      workload            = string
    })
  )

}

