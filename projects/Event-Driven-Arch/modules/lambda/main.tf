resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.lambda_package

  source_code_hash = filebase64sha256(var.lambda_package)

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}