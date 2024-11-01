variable "vpc_id" {
  description = "The VPC ID where the security groups will be created."
  type        = string
}

variable "load_balancer_sg_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "subnet_cidrs_vpc" {
  description = "CIDR blocks for the VPC subnets"
  type        = string
}

variable "bastion_sg_id" {
  description = "The security group ID for the bastion host"
  type        = string
}

# variable "private_subnet_cidrs" {
#   description = "List of CIDR blocks for private subnets"
#   type        = list(string)
# }