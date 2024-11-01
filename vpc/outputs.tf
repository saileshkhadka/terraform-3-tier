# vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.partneraX_VPC.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private2[*].id
}

output "private_subnet_ids_ec2" {
  value = aws_subnet.private[*].id
}

# output "private_subnet_cidrs" {
#   value = aws_subnet.private_subnets[*].cidr_block
# }

output "private_subnet_cidrs" {
  value = concat(
    aws_subnet.private[*].cidr_block,
    aws_subnet.private2[*].cidr_block
  )
}