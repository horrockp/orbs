output "alb_dns_name" {
  value = aws_elb.main.dns_name
}

output "nat_gateway_primary" {
  value = aws_nat_gateway.nat.public_ip
}

output "nat_gateway_secondary" {
  value = aws_eip.nat_secondary.public_ip
}
