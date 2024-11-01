# vpc/variables.tf

variable "vpc_name" {
  type = string
}

variable "subnet_cidrs_vpc" {
  type = string
}

variable "subnet_public_cidrs" {
  type = list(string)
}

variable "subnet_private_cidrs" {
  type = list(string)
}

variable "subnet_private2_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}
