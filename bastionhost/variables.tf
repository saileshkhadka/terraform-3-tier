variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "ec2_key_pair" {
  description = "The name of the EC2 key pair"
  type        = string
}

variable "bastion_ami_id" {
  description = "AMI ID for the Bastion host"
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion host"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "instance_sg_id" {
  description = "Security group ID for the backend EC2 instances"
}

variable "db_sg_id" {
  description = "Security group ID for the database"
}

variable "bastion_sg_id" {
  description = "Bastion host security group ID"
  type        = string
}