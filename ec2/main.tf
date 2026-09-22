resource "aws_instance" "wed_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  key_name = "Laptop"
  associate_public_ip_address = false

  user_data = <<-EOT

  #!/bin/bash

  apt update -y
  apt install -y httpd
  systemctl start httpd
  systemctl enable httpd
  echo "Hello sir"> /var/www/html/index.launch_template {
    EOT
  tags = {
    Name = "Private ec2 instance"
  }
}
