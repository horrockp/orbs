output "alb_dns_name" {
  value = aws_elb.main.dns_name
}

output "nat_gateway" {
  value = aws_nat_gateway.nat.public_ip
}
