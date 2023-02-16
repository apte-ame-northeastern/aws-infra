locals {
  private_subnet_cidrs = [for netnumber in range(1, var.priv_sub_count + 1) : cidrsubnet(var.cidr, 8, netnumber)]
  public_subnet_cidrs  = [for netnumber in range(var.priv_sub_count + 1, var.priv_sub_count + var.pub_sub_count + 1) : cidrsubnet(var.cidr, 8, netnumber)]
}

resource "aws_vpc" "ameya" {
  cidr_block = var.cidr

  tags = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "ameya_private_subnet" {
  vpc_id = aws_vpc.ameya.id

  count             = var.priv_sub_count
  cidr_block        = element(local.private_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index % length(data.aws_availability_zones.azs.names)]

  map_public_ip_on_launch = false

  tags = {
    Name        = "Private Subnet ${count.index + 1}"
    Environment = "${var.environment}"
  }

  depends_on = [
    aws_vpc.ameya
  ]
}

resource "aws_subnet" "ameya_public_subnet" {
  vpc_id = aws_vpc.ameya.id

  count             = var.pub_sub_count
  cidr_block        = element(local.public_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "Public Subnet ${count.index + 1}"
    Environment = "${var.environment}"
  }

  depends_on = [
    aws_vpc.ameya
  ]
}

resource "aws_internet_gateway" "ameya_internet_gateway" {
  vpc_id = aws_vpc.ameya.id

  tags = {
    Name = "Internet Gateway"
  }

  depends_on = [
    aws_vpc.ameya
  ]
}

resource "aws_route_table" "ameya_public_route_table" {
  vpc_id = aws_vpc.ameya.id

  tags = {
    Name = "Public Route Table"
  }

  depends_on = [
    aws_subnet.ameya_public_subnet
  ]
}


resource "aws_route" "ameya_public_route" {

  route_table_id         = aws_route_table.ameya_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ameya_internet_gateway.id

  depends_on = [
    aws_route_table.ameya_public_route_table
  ]
}


resource "aws_route_table_association" "ameya_pub_rt_association" {
  count          = length(local.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.ameya_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.ameya_public_route_table.id

  depends_on = [
    aws_route_table.ameya_public_route_table
  ]
}

resource "aws_route_table" "ameya_private_route_table" {
  vpc_id = aws_vpc.ameya.id

  tags = {
    Name = "Private Route Table"
  }

  depends_on = [
    aws_subnet.ameya_private_subnet
  ]
}

resource "aws_route_table_association" "ameya_priv_rt_association" {
  count          = length(local.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.ameya_private_subnet.*.id, count.index)
  route_table_id = aws_route_table.ameya_private_route_table.id

  depends_on = [
    aws_route_table.ameya_private_route_table
  ]
}

