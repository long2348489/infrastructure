data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = length(data.aws_availability_zones.available.names)
}

resource "aws_vpc" "name" {
  cidr_block = var.cidr_block
  tags       = var.default_tags
}

resource "aws_subnet" "public_subnet" {
  depends_on        = [aws_vpc.this]
  count             = local.azs
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.this.id
  tags = merge({
    pubclic-aws_subnet = "true"
  }, var.default_tags)
}

resource "aws_subnet" "private_subnet" {
  depends_on        = [aws_vpc.this]
  count             = local.azs
  cidr_block        = cidrsubnet(var.cidr_block, 8, local.azs + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.this.id
  tags = merge({
    pubclic-aws_subnet = "false"
  }, var.default_tags)
}

# resource "aws_nat_subnet" "ngw" {
#   depends_on = [aws_vpc.this]
#   count      = local.azs
#   subnet_id  = element(aws_subnet.public_subnet.*.id, count.index)
# }
