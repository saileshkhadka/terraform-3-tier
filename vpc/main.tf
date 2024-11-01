# vpc/main.tf
resource "aws_vpc" "partneraX_VPC" {
  cidr_block       = var.subnet_cidrs_vpc
  instance_tenancy = "default"

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "public" {
  count              = length(var.subnet_public_cidrs)
  vpc_id             = aws_vpc.partneraX_VPC.id
  cidr_block         = element(var.subnet_public_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count              = length(var.subnet_private_cidrs)
  vpc_id             = aws_vpc.partneraX_VPC.id
  cidr_block         = element(var.subnet_private_cidrs, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.vpc_name}-private-ec2-${count.index + 1}"
  }
}

resource "aws_subnet" "private2" {
  count              = length(var.subnet_private2_cidrs)
  vpc_id             = aws_vpc.partneraX_VPC.id
  cidr_block         = element(var.subnet_private2_cidrs, count.index)
  availability_zone  = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.vpc_name}-private-rds-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "partneraX_ig" {
  vpc_id = aws_vpc.partneraX_VPC.id

  tags = {
    Name = "${var.vpc_name}-ig"
  }
}

resource "aws_nat_gateway" "partneraX_nat_gw" {
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-nat-gw-1"
  }
}

resource "aws_eip" "Nat-Gateway-EIP" {
  # domain = "vpc"

  tags = {
    Name = "${var.vpc_name}-nat-gw-eip-1"
  }
}

resource "aws_eip" "Nat-Gateway-EIP-2" {
  # domain = "vpc"

  tags = {
    Name = "${var.vpc_name}-nat-gw-eip-2"
  }
}

resource "aws_nat_gateway" "partneraX_nat_gw_2" {
  allocation_id = aws_eip.Nat-Gateway-EIP-2.id
  subnet_id     = aws_subnet.public[1].id
  tags = {
    Name = "${var.vpc_name}-nat-gw-2"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.partneraX_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.partneraX_ig.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.partneraX_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.partneraX_nat_gw.id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt-1"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.partneraX_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.partneraX_nat_gw_2.id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt-2"
  }
}


resource "aws_route_table_association" "public" {
  count              = length(aws_subnet.public)
  subnet_id          = element(aws_subnet.public.*.id, count.index)
  route_table_id     = aws_route_table.public.id
}

# resource "aws_route_table_association" "private" {
#   count              = length(aws_subnet.private)
#   subnet_id          = aws_subnet.private[count.index].id
#   route_table_id     = aws_route_table.private.id
# }

# resource "aws_route_table_association" "private2" {
#   count              = length(aws_subnet.private2)
#   subnet_id          = aws_subnet.private2[count.index].id
#   route_table_id     = aws_route_table.private2.id
# }


resource "aws_route_table_association" "private_ec2_1" {
  subnet_id          = aws_subnet.private[0].id
  route_table_id     = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rds_1" {
  subnet_id          = aws_subnet.private2[0].id
  route_table_id     = aws_route_table.private.id
}

resource "aws_route_table_association" "private_ec2_2" {
  subnet_id          = aws_subnet.private[1].id
  route_table_id     = aws_route_table.private2.id
}

resource "aws_route_table_association" "private_ec2_3" {
  subnet_id          = aws_subnet.private[2].id
  route_table_id     = aws_route_table.private2.id
}

resource "aws_route_table_association" "private_rds_2" {
  subnet_id          = aws_subnet.private2[1].id
  route_table_id     = aws_route_table.private2.id
}

resource "aws_route_table_association" "private_rds_3" {
  subnet_id          = aws_subnet.private2[2].id
  route_table_id     = aws_route_table.private2.id
}