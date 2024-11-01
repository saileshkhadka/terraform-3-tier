variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_master_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "db_cluster_instance_class" {
  description = "The instance class for the RDS cluster instances"
  type        = string
}

# variable "db_cluster_count" {
#   description = "The number of RDS cluster instances"
#   type        = number
# }

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
  type        = list(string)
}

variable "subnet_private2_cidrs" {
  description = "CIDR blocks for the VPC subnets"
  type        = list(string)
  default     = ["10.0.7.0/24", "10.0.9.0/24", "10.0.11.0/24"]
}

# variable "load_balancer_sg_id" {
#   description = "Adding security group inbound rule for ec2"
#   type = string
# }

variable "bastion_sg" {
  description = "bastion-host sg"
}

variable "db_sg_id" {
  type = string
}

variable "secret_name" {
  description = "The secret name of the db"
  type        = string
}