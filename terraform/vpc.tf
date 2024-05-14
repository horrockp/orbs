resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_1
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_names[0]
  tags = {
    "Name" = "public_1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_2
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_names[1]
  tags = {
    "Name" = "public_2"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.availability_zone_names[0]
  tags = {
    "Name" = "private_1"
  }
}

# These VPC endpoint are for session manager access to EC2
resource "aws_vpc_endpoint" "ssm" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.eu-west-2.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private.id]
  security_group_ids = [aws_security_group.endpoint.id]
  private_dns_enabled = true
  tags = {
    "Name" = "ssm"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.eu-west-2.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private.id]
  security_group_ids = [aws_security_group.endpoint.id]
  private_dns_enabled = true
  tags = {
    "Name" = "ssmmessages"
  }
}

resource "aws_vpc_endpoint" "ec2mmessages" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.eu-west-2.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private.id]
  security_group_ids = [aws_security_group.endpoint.id]
  private_dns_enabled = true
  tags = {
    "Name" = "ec2messages"
  }
}


