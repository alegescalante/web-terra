####### ssh ####### 
# ssh-keygen -t rsa -b 2048 -f "nginx-server.key"

resource "aws_key_pair" "nginx-server-ssh" {
  key_name   = "${var.server_name}-ssh"
  public_key = file("${var.server_name}.key.pub")

  tags = {
    Name        = "${var.server_name}-ssh"
    Environment = var.server_name
    Owner       = "alegescalante@gmail.com"
    Team        = "Prueba-nginx"
    Project     = "webinar"
  }
}