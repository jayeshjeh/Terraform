  user_data = <<-EOF
     #!/bin/bash
     	sudo apt-get update
     	sudo apt-get install -y nginx
        sudo apt install git -y
     	echo "<h1>${var.environment}-Server-1</h1>" | sudo tee /var/www/html/index.html
        echo "<h1>${var.vpc_name}-private-server-${count.index + 1}</h1>" | sudo tee /var/www/html/index.html
        echo "<h1> git --version </h1>" | sudo tee /var/www/html/index.html
     	sudo systemctl start nginx
     	sudo systemctl enable nginx

     EOF
