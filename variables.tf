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

variable "email_points" {
  description = "List of email addresses"
  type        = list(string)
  default     = []
}
variable "alerts" {
  description = "List of alert names and expressions"
  type = list(
    object({
      name = string
      expr = string
    })
  )
}

