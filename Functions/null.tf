resource "null_resource" "cluster" {
  count = var.environment == "prod" ? 3 : 1
  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("us.pem")
      host        = element(aws_instance.public-servers.*.public_ip, count.index)
    }

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/user-data.sh",
      "sudo /tmp/user-data.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("us.pem")
      host        = element(aws_instance.public-servers.*.public_ip, count.index)
    }

  }
}