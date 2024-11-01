# loadbalancer/variables.tf

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "instance_ids" {
  type = list(string)
}

variable "asg_name" {
  type = string
}

variable "load_balancer_sg_id" {
  description = "Security group ID for the load balancer"
  type        = string
}

variable "certificate_arn" {
  description = "Certificate arn url"
  type = string
}