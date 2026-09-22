output "instance_id" {
  value = aws_instance.wed_server.id
}

output "public_id" {
  value = aws_instance.wed_server.public_ip
}
