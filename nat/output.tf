output "nat_gateway_id" {
  value = aws_nat_gateway.main.id
}

output "nat_eid" {
  value = aws_eip.nat_eip.public_ip
}
