resource "aws_eip" "nat_eip" {
  # vpc                       = true

  }

  resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.public_subnet_id
  }
