output "loadblancer_dns_name" {
  value = module.loadblancer.loadblancer_dns_name
}
output "ec2_public_ip" {
  value = module.ec2.public_id
}
