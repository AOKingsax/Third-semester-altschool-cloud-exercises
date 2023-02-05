## INSTANCE

resource "aws_instance" "webserver" {
    ami                    = var.image_id
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.public_subnet1.id    
    vpc_security_group_ids = [aws_security_group.guard.id]
    key_name               = "key"

    root_block_device {
    volume_size = 8
  }

    user_data = <<EOF
#! /bin/bash
sudo apt update
sudo apt install apache2 -y
sudo service start apache2
EOF

  tags = local.common_tags
}

resource "aws_instance" "webserver1" {
    ami                    = var.image_id
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.public_subnet2.id    
    vpc_security_group_ids = [aws_security_group.guard.id]
    key_name               = "key"

    root_block_device {
    volume_size = 8
  }

    user_data = <<EOF
#! /bin/bash
sudo apt update
sudo apt install nginx -y
sudo service start nginx
EOF

  tags = local.common_tags
}

resource "aws_instance" "webserver2" {
    ami                    = var.image_id
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.public_subnet3.id
    vpc_security_group_ids = [aws_security_group.guard.id]
    key_name               = "key"

    root_block_device {
    volume_size = 8
  }

    user_data = <<EOF
#! /bin/bash
sudo apt update
sudo apt install apache2 -y
sudo service start apache2
echo "<h1>server hostname is $(hostname)</h1>" > /var/www/html/index.html
sudo service restart apache2
EOF

  tags = local.common_tags
}