variable "lambda_function_arn" {}
variable "sqs_queue_arn" {}
variable "batch_size" {
  default = 10
}
variable "depends_on_lambda" {}
variable "depends_on_sqs" {}

