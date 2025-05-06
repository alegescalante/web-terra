####### modulos #######
module "nginx_server_dev" {
    source = "./nginx_server_module"

    ami_id           = "ami-0f88e80871fd81e91"
    instance_type    = "t3.micro"
    server_name      = "nginx-server-dev"
    environment      = "dev"
}

#######  output ####### 
output "nginx_dev_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = module.nginx_server_dev.server_public_ip
}

output "nginx_dev_dns" {
  description = "DNS público de la instancia EC2"
  value       = module.nginx_server_dev.server_public_dns
}