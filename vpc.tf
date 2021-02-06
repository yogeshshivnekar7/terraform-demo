#  VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "70.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "my_vpc"
  }
}

# Subnets
resource "aws_subnet" "Public_SN_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "70.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "Public_SN_1"
  }
}

resource "aws_subnet" "Public_SN_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "70.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "Public_SN_2"
  }
}

resource "aws_subnet" "Public_SN_3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "70.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "Public_SN_3"
  }
}

resource "aws_subnet" "Private_SN_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "70.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "Private_SN_1"
  }
}

resource "aws_subnet" "Private_SN_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "70.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "Private_SN_2"
  }
}

resource "aws_subnet" "Private_SN_3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "70.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "Private_SN_3"
  }
}

# Internet GW
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

# route tables
resource "aws_route_table" "Public_RT" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "Public_RT"
  }
}

# route associations public
resource "aws_route_table_association" "Public_SN_1-a" {
  subnet_id      = aws_subnet.Public_SN_1.id
  route_table_id = aws_route_table.Public_RT.id
}

resource "aws_route_table_association" "Public_SN_2-a" {
  subnet_id      = aws_subnet.Public_SN_2.id
  route_table_id = aws_route_table.Public_RT.id
}

resource "aws_route_table_association" "Public_SN_3-a" {
  subnet_id      = aws_subnet.Public_SN_3.id
  route_table_id = aws_route_table.Public_RT.id
}
