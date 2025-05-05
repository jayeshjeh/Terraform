output "lambda_role_arn" {
    value = aws_iam_role.lambda_exec.arn
}

output "sqs_read_policy_arn" {
    value = aws_iam_policy.sqs_read_policy.arn
}

output "cw_logs_policy_arn" {
    value = aws_iam_policy.cw_logs_policy.arn
}