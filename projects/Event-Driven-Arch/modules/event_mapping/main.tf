resource "aws_lambda_event_source_mapping" "this" {
  function_name    = var.lambda_function_arn
  event_source_arn = var.sqs_queue_arn
  enabled          = true
  batch_size       = var.batch_size

  depends_on = [
    var.depends_on_lambda,
    var.depends_on_sqs
  ]
}
