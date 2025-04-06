resource "aws_iam_instance_profile" "this" {
    name = var.instance_profile_name
    role = aws_iam_role.this.name
}