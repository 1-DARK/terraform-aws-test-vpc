resource "aws_vpc" "main" {
  cidr_block = var.vpc.cidr_block
  tags = {
    Name = var.vpc.name
  }
}

resource "aws_subnet" "main1" {
  vpc_id            = aws_vpc.main.id
  for_each          = var.subnet_config
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}

locals {
  public_subnets = {
    for key, config in var.subnet_config : key => config if config.public
  }
  private_subnets = {
    for key, config in var.subnet_config : key => config if !config.public
  }
}

resource "aws_internet_gateway" "main2" {
  vpc_id = aws_vpc.main.id
  count  = length(local.public_subnets) > 0 ? 1 : 0
  tags = {
    Name = "my-gateway"
  }
}

resource "aws_route_table" "main3" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main2[0].id
  }
  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "main4" {
  for_each       = local.public_subnets
  route_table_id = aws_route_table.main3[0].id
  subnet_id      = aws_subnet.main1[each.key].id
}
