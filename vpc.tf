
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "AZHAR-CGP"
  }
}
resource "aws_subnet" "azhar-cgp-private-subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "azhar-cgp-private-subnet1"
  }
}
resource "aws_subnet" "azhar-cgp-public-subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "azhar-cgp-public-subnet2"
  }
}
resource "aws_subnet" "azhar-cgp-private-subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "azhar-cgp-private-subnet2"
  }
}
resource "aws_subnet" "azhar-cgp-public-subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "azhar-cgp-public-subnet1"
  }
}
resource "aws_route_table" "public-route-azhar" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "public-route-azhar"
  }
}
resource "aws_route_table" "private-route-azhar" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private-route-azhar"
  }
}
resource "aws_route_table_association" "public-route-azhar1" {
  subnet_id      = aws_subnet.azhar-cgp-public-subnet1.id
  route_table_id = aws_route_table.public-route-azhar.id
}
resource "aws_route_table_association" "public-route-azhar2" {
  subnet_id      = aws_subnet.azhar-cgp-public-subnet2.id
  route_table_id = aws_route_table.public-route-azhar.id
}
resource "aws_route_table_association" "private-route-azhar1" {
  subnet_id      = aws_subnet.azhar-cgp-private-subnet1.id
  route_table_id = aws_route_table.private-route-azhar.id
}
resource "aws_route_table_association" "private-route-azhar2" {
  subnet_id      = aws_subnet.azhar-cgp-private-subnet2.id
  route_table_id = aws_route_table.private-route-azhar.id
}
resource "aws_internet_gateway" "IGW-azhar" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW-azhar"
  }
}
resource "aws_route" "routing" {
  route_table_id            = aws_route_table.public-route-azhar.id
  gateway_id = aws_internet_gateway.IGW-azhar.id
  destination_cidr_block    = "0.0.0.0/0"
}
resource "aws_eip" "azhar" {
  domain = "vpc"  # Set to true if you're working in a VPC environment, false if EC2-Classic

  # Optionally specify an existing allocation ID if needed
  # allocation_id = "eipalloc-xxxxxxxx"

  tags = {
    Name = "azhar"
  }
}
resource "aws_nat_gateway" "azhar-nat-gateway" {
  allocation_id = aws_eip.azhar.id
  subnet_id     = aws_subnet.azhar-cgp-public-subnet1.id
  tags = {
    Name = "azhar-nat-gateway"
     }
 }
resource "aws_route" "routing2" {
  route_table_id = aws_route_table.private-route-azhar.id
  gateway_id = aws_nat_gateway.azhar-nat-gateway.id
  destination_cidr_block    = "0.0.0.0/0"
}

