resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project3-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project3-internet-gateway"
  }
}

resource "aws_subnet" "public_one" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_one_cidr
  availability_zone       = var.availability_zone_one
  map_public_ip_on_launch = true

  tags = {
    Name = "project3-public-subnet-one"
    Type = "Public"
  }
}

resource "aws_subnet" "public_two" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_two_cidr
  availability_zone       = var.availability_zone_two
  map_public_ip_on_launch = true

  tags = {
    Name = "project3-public-subnet-two"
    Type = "Public"
  }
}

resource "aws_subnet" "private_one" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_one_cidr
  availability_zone       = var.availability_zone_one
  map_public_ip_on_launch = false

  tags = {
    Name = "project3-private-subnet-one"
    Type = "Private"
  }
}

resource "aws_subnet" "private_two" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_two_cidr
  availability_zone       = var.availability_zone_two
  map_public_ip_on_launch = false

  tags = {
    Name = "project3-private-subnet-two"
    Type = "Private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project3-public-route-table"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_one" {
  subnet_id      = aws_subnet.public_one.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_two" {
  subnet_id      = aws_subnet.public_two.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project3-private-route-table"
  }
}

resource "aws_route_table_association" "private_one" {
  subnet_id      = aws_subnet.private_one.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_two" {
  subnet_id      = aws_subnet.private_two.id
  route_table_id = aws_route_table.private.id
}
