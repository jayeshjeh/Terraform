variable "function_name" {}
variable "lambda_role_arn" {}
variable "handler" {
  default = index.handler
}
variable "runtime" {}
variable "lambda_package" {}
variable "environment_variables" {
  default = {}
}
variable "tags" {
  default = {}
}