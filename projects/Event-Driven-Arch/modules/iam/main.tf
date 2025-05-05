
# This allows AWS Lambda service to assume the role

data "aws_iam_policy_document" "lambda_assume_role" {
    statement {
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
}


# Policy to allow reading from SQS Queue

data "aws_iam_policy_document" "sqs_read" {
    statement {
      actions = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:ChangeMessageVisibility"
      ]
      resources = var.sqs_queue_arns
    }
}


# Policy to allow writing to Cloudwatch logs

data "aws_iam_policy_document" "cw_logs" {
    statement {
      actions = [
        "logs:CloudLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      resources = ["arn:aws:logs:${var.region}:*:*"]
    }
}


# Create IAM Role that Lambda will assume

resource "aws_iam_role" "lambda_exec" {
    name = "${var.name_prefix}-lambda-exec-role"
    assume_role_policy = data.aws_iam_policy_document.lambda_assume_role
    tags = var.tags
}


# Create IAM Policy for SQS access

resource "aws_iam_policy" "sqs_read_policy" {
    name = "${var.name_prefix}-sqs-read"
    description = "Allow Lambda to Receive, Delete and Change visibility of SQS Messages"
    policy = data.aws_iam_policy_document.sqs_read

}


# Create IAM Policy for Cloudwatch Logs

resource "aws_iam_policy" "cw_logs_policy" {
    name = "${var.name_prefix}-cw-logs"
    description = "Allow Lambda to create and watch CLoudWatch Logs"
    policy = data.aws_iam_policy_document.cw_logs
  
}


# Attach SQS read policy to Role

resource "aws_iam_role_policy_attachment" "attach_sqs_read" {
    role = aws_iam_role.lambda_exec.name
    policy_arn = aws_iam_policy.cw_logs_policy.arn
}


#Attach Cloudwatch Policy to role

resource "aws_iam_role_policy_attachment" "attach_cw_logs" {
    role = aws_iam_policy.cw_logs_policy.name
    policy_arn = aws_iam_policy.cw_logs_policy.arn
  
}