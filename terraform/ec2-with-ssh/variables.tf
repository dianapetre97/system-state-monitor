variable "ami" {
  description = "image id pt ec2"
  type        = string
}

variable "instance_type" {
  description = "tipul instantei"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Numele cheii SSH"
  type        = string
}


variable "subnet_id" {
  description = "subnetul in care o sa fie instanta"
  type        = string
}

variable "instance_name" {
  description = "numele instantei"
  type        = string
}

variable "public_key_path" {
  description = "calea catre fisierul in care se afla cheia publica"
  type        = string
}