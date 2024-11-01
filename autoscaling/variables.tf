variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "desired_capacity" {
  description = "The desired capacity of the Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group"
  type        = number
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling group"
  type        = number
}

variable "ec2_key_pair" {
  description = "The name of the EC2 key pair"
  type        = string
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "app_prefix" {
  description = "The prefix for the application"
  type        = string
}

variable "load_balancer_sg_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "db_sg_id" {
  description = "Security group ID for the database"
  type        = string
}

variable "target_group_arns" {
  type = list(string)
  description = "List of target group ARNs"
}

variable "private_subnet_ids_ec2" {
  description = "List of private subnet IDs"
  type        = list(string)
}

# variable "public_subnet_ids" {
#   description = "List of private subnet IDs"
#   type        = list(string)
# }


variable "bastion_sg" {
  description = "bastion-host sg"
}

variable "instance_sg_id" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key"
  type        = string
}