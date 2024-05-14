output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "nat_gateway_ips" {
  value = aws_nat_gateway.main.public_ip
}