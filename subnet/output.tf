output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "Private_subnet_id" {
  value = aws_subnet.private_subnet.id

}
output "subnet_ids" {
  value = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
  #value = [aws_subnet.public.id, aws_subnet.private.id]
}
