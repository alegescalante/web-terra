####### Variables #######

variable "ami_id" {
  description = "ID de la AMI para la instancia EC2"
  default     = "ami-0f88e80871fd81e91"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t3.micro"
}

variable "server_name" {
  description = "Nombre del servidor web"
  default     = "nginx-server"
}

variable "environment" {
  description = "Ambiente de la aplicación"
  default     = "prueba"
}