output "all_subnets" {
    value = aws_subnet.multi_subnet
}

output "public_sg_id" {
  value = aws_security_group.sg_public.id
}

output "sg_rds" {
    value = aws_security_group.rds_private.id
}