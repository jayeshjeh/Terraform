resource "null_resource" "cluster" {
  provisioner "file" {
    source      = user-data.sh
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("us")
      host        = element(aws_instance.public-servers.*.public_ip, count.index + 1)
    }

  }

}