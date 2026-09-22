provider "aws" {
  region = "ap-northeast-1"
}
#vpc module
module "vpc" {
  source = "./vpc"
  cidr_block = "10.0.0.0/16"
}
#subnet module
module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc_id
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  public_subnet_availability_zone = "ap-northeast-1a"
  private_subnet_availability_zone = "ap-northeast-1c"
}
#internet gateway module
module "internet_gateway" {
  source = "./igw"
  vpc_id = module.vpc.vpc_id
}
#Nat gateway module
module "nat_gateway" {
  source = "./nat"
  public_subnet_id = module.subnet.public_subnet_id
}
#Route table module
module "route_table" {

  source = "./route_table"
  vpc_id = module.vpc.vpc_id
  internet_gateway_id   = module.internet_gateway.internet_gateway_id
  nat_gateway_id = module.nat_gateway.nat_gateway_id
  public_subnet_id = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.Private_subnet_id
}
#ec2 instance modal
module "ec2" {
  source = "./ec2"
  ami_id = "ami-0126975fb247bf2e7"
  instance_type = "t3.micro"
  private_subnet_id = module.subnet.Private_subnet_id
}

#Load blancer module
module "loadblancer" {
  source ="./lb"
  vpc_id = module.vpc.vpc_id
  subnet = module.subnet.subnet_ids
  #subnet = [module.subnet.public_subnet.id, module.subnet.private_subnet.id]
ec2_instance_id = module.ec2.instance_id
security_groups    = [aws_security_group.lb_sg.id]

}

resource "aws_security_group" "lb_sg" {
  name        = "alb-security-group"
  description = "Allows public web traffic to the Application Load Balancer"
  vpc_id      = module.vpc.vpc_id

  # Inbound HTTP Traffic
  ingress {
    description = "Allow HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTPS Traffic
  ingress {
    description = "Allow HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Traffic to Backend Targets
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}
