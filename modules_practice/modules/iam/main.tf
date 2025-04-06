resource "aws_iam_role" "this" {
  name = var.IAM_role_name

  assume_role_policy = <<EOF
  {
    "Version" = "2012-10-17"
    "Statement" = [
        {
            "Action" = "sts:AssumeRole"
            "Principal" = 
            {
                "Service" = "ec2.amazonaws.com"
            },
          "Effect" = "Allow",
          "Sid" = ""

        }
    ]
    }
    EOF

    tags = {
        environment = var.environment
    }
    
}