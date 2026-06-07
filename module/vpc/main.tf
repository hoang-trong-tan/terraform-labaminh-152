resource "aws_vpc" "testing" {
  cidr_block = var.vpc_cidr
  tags = var.vpc_tag
}

resource "aws_subnet" "multi_subnet" {
  for_each = var.subnets

  cidr_block = each.value.cidr_block
  vpc_id = aws_vpc.testing.id
  availability_zone = each.value.az

  map_public_ip_on_launch = each.value.tier == "public" ? true : false

  tags = {
    Name = each.key
    Tier = each.value.tier
  }

}

resource "aws_internet_gateway" "igw_public" {
  vpc_id = aws_vpc.testing.id
  tags = var.vpc_tag
}

resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw_public.id
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.testing.id
}

resource "aws_route_table_association" "public" {
    for_each = {
      for k, v in aws_subnet.multi_subnet : k => v if v.tags["Tier"] == "public" 
    }
    subnet_id = each.value.id
    route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "sg_public" {
  vpc_id = aws_vpc.testing.id
  tags = var.vpc_tag
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.sg_public.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "rds_private" {
  vpc_id = aws_vpc.testing.id
  name = "rds-sg"
}

resource "aws_security_group_rule" "rds_ingress" {
  security_group_id = aws_security_group.rds_private.id
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = aws_security_group.sg_public.id
}
