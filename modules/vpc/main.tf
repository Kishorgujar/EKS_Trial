# Public VPC
resource "aws_vpc" "public_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets
resource "aws_subnet" "public_pub_sub1" {
  count = length(var.public_pub_subnet1_cidrs)
  vpc_id            = aws_vpc.public_vpc.id
  cidr_block        = element(var.public_pub_subnet1_cidrs, count.index)
  availability_zone = element(var.azs, count.index)  # First AZ for Subnet 1
  tags = {
    Name = "Public_Pub_Sub1-${count.index}"
  }
}

resource "aws_subnet" "public_pub_sub2" {
  count = length(var.public_pub_subnet2_cidrs)
  vpc_id            = aws_vpc.public_vpc.id 
  cidr_block        = element(var.public_pub_subnet2_cidrs, count.index)
  availability_zone = element(var.azs, count.index + length(var.public_pub_subnet1_cidrs))  # Second AZ for Subnet 2
  tags = {
    Name = "Public_Pub_Sub2-${count.index}"
  }
}

# Public Route Tables
resource "aws_route_table" "public_pub_route1" {
  vpc_id = aws_vpc.public_vpc.id
  tags = {
    Name = "Public_Pub_route1"
  }
}

resource "aws_route_table" "public_pub_route2" {
  vpc_id = aws_vpc.public_vpc.id
  tags = {
    Name = "Public_Pub_route2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.public_vpc.id
  tags = {
    Name = "Public_igw"
  }
}

resource "aws_route_table_association" "public_pub_sub_association1" {
  count     = length(aws_subnet.public_pub_sub1)  # Ensure this matches your subnet count
  subnet_id      = aws_subnet.public_pub_sub1[count.index].id
  route_table_id = aws_route_table.public_pub_route1.id
}

resource "aws_route_table_association" "public_pub_sub_association2" {
  count     = length(aws_subnet.public_pub_sub2)  # Ensure this matches your subnet count
  subnet_id      = aws_subnet.public_pub_sub2[count.index].id
  route_table_id = aws_route_table.public_pub_route2.id
}

resource "aws_route" "public_route1" {
  route_table_id         = aws_route_table.public_pub_route1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.public_igw.id
}

resource "aws_route" "public_route2" {
  route_table_id         = aws_route_table.public_pub_route2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.public_igw.id
}
