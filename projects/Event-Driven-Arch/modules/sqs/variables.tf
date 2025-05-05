variable "queue_name" {}
variable "delay_seconds" {
  default = 0
}

variable "visibility_timeout" {
    default = 30
}

variable "message_retention_seconds" {
    default = 84600
}

variable "receive_wait_time_seconds" {
    default = 0
}

variable "tags" {
  default = {}
}