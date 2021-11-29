# VPC
resource "aws_vpc" "example_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

# パブリックサブネット
resource "aws_subnet" "example_subnet_a" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "example-subnet-a"
  }
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example-igw"
  }
}

# ルートテーブル
resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example-route-table"
  }
}

# ルート
resource "aws_route" "example_route" {
  route_table_id         = aws_route_table.example_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example_igw.id
}

# ルートテーブルとの関連付け
resource "aws_route_table_association" "example_route_table_a" {
  route_table_id = aws_route_table.example_route_table.id
  subnet_id      = aws_subnet.example_subnet_a.id
}