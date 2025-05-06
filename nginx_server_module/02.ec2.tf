####### resource #######
resource "aws_instance" "nginx-server" {
  ami = var.ami_id
  instance_type = var.instance_type 
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
          
  key_name = aws_key_pair.nginx-server-ssh.key_name
  
  vpc_security_group_ids = [
	aws_security_group.nginx-server-sg.id
  ]
  
  tags = {
    Name        = var.server_name
    Environment = var.environment
    Owner       = "alegescalante@gmail.com"
    Team        = "Prueba-nginx"
    Project     = "webinar"
  }

}