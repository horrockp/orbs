# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_primary" {
  domain   = "vpc"
}

resource "aws_eip" "nat_secondary" {
  domain   = "vpc"
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_primary.id
  subnet_id     = aws_subnet.public_1.id
  secondary_allocation_ids  = [aws_eip.nat_secondary.id]

    tags = {
    Name = "gw NAT"
  }
  depends_on = [aws_internet_gateway.main]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = {
    Name = "public-rt"
  }
}

# Associations for Public Subnets
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table with NAT Gateway route
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

# Association for the Private Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}