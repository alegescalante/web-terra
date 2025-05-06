####### modulos #######
module "nginx_server_dev" {
    source = "./nginx_server_module"

    ami_id           = "ami-0f88e80871fd81e91"
    instance_type    = "t3.micro"
    server_name      = "nginx-server-dev"
    environment      = "dev"
}

module "nginx_server_qa" {
    source = "./nginx_server_module"

    ami_id           = "ami-0f88e80871fd81e91"
    instance_type    = "t3.micro"
    server_name      = "nginx-server-qa"
    environment      = "qa"
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

output "nginx_qa_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = module.nginx_server_qa.server_public_ip
}

output "nginx_qa_dns" {
  description = "DNS público de la instancia EC2"
  value       = module.nginx_server_qa.server_public_dns
}

#para importar de aws correr el siguiente comando
#terraform import aws_instance.server-web i-0f6c19601ef5ad9e9 (el numero corresponde al id de la instacncia en aws)
#obs, crear antes de correr el comando la esctructura vacia:
#resource "aws_instance" "server-web" {
#   (resource arguments)
#}

#### Import
#resource "aws_instance" "server-web" {
  #(resource arguments)
#}

#para el estado de la instancia correr el siguiente comando
#terraform state show aws_instance.server-web
