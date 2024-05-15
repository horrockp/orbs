# Security Group for EC2 Instances
resource "aws_security_group" "ec2" {
  vpc_id = aws_vpc.main.id

  // rule for http
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
    description     = "Allow HTTP traffic from the load balancer"
  }

  // rule for HTTPS
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
    description     = "Allow HTTPS traffic from the load balancer"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # This should be behind a firewall. Required to access external Linux packages (Docker). An alternative would be to use the S3 VPC endpoint pull packages from AWS. This could then be locked to the VPC cidr.
    description     = "Allow all traffic to the load balancer"
  }
   tags = {
    "Name" = "ec2-sg"
  }
}

# Security Group for Load Balancer
resource "aws_security_group" "lb" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # If Production, this shold be locked down to an IP range  or behind a WAF if open to the public 
    description     = "Allow port 80"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow All"
  }
   tags = {
    "Name" = "lb-sg"
  }
}

# Security Group for Endpoints
resource "aws_security_group" "endpoint" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow port 443"
  }
  tags = {
    "Name" = "endpoint-sg"
  }
}
