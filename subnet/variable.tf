variable "public_subnet_cidr" {

  default = "10.0.1.0/24"

}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "public_subnet_availability_zone" {
  default = "ap-northeast-1a"
}

variable "private_subnet_availability_zone" {
  default = "ap-northeast-1c"
}

variable "vpc_id" {
  description = "vpc id where subnet will be created"
}
