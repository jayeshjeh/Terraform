output "private_servers" {
  value = aws_instance.private.*.id
}

output "public_servers" {
  value = aws_instance.public.*.id

}