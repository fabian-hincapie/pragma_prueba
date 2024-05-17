# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "vpc-${var.project}"
    Environment = var.environment
  }
}

# Public subnet a
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidr_a
  availability_zone       = "${var.AWS_REGION}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet-${var.project}-a"
    Environment = "${var.environment}"
  }
}

# Public subnet b
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidr_b
  availability_zone       = "${var.AWS_REGION}b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet-${var.project}-b"
    Environment = "${var.environment}"
  }
}

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "igw-${var.project}"
    Environment = var.environment
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name        = "rt-pub-${var.project}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "ass_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "ass_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

##########################
# Private Subnet a 
resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets_cidr_a
  availability_zone       = "${var.AWS_REGION}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "private-subnet${var.project}-a"
    Environment = "${var.environment}"
  }
}

# Private Subnet b
resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets_cidr_b
  availability_zone       = "${var.AWS_REGION}b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "private-subnet${var.project}-a"
    Environment = "${var.environment}"
  }
}

# Elastic-IP (eip) for NAT
resource "aws_eip" "eip" {
  tags = {
    Name        = "eip-${var.project}"
    Environment = "${var.environment}"
  }
}

# NAT A
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name        = "nat-gw-${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name        = "rt-priv-${var.project}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "ass_priv_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.priv_rt.id
}

resource "aws_route_table_association" "ass_priv_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.priv_rt.id
}