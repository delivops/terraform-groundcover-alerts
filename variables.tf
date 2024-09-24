variable "client_name" {
  type        = string
  description = "client_name"
}
variable "cluster_name" {
  type        = string
  description = "cluster name"
}
variable "service_account" {
  type        = string
  description = "generated service account"
}

variable "contact_point_name" {
  type        = string
  description = "contact_point_name"
  default     = "opsgenie"
}
variable "folder_name" {
  type        = string
  description = "folder name"
  default     = "custom alerts"
}
variable "alerts" {
  description = "List of alert configurations"
  type = list(object({
    type      = string
    threshold = number
    severity  = string
    contact   = string
  }))
}

