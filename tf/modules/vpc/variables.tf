variable "vpc_all_cidr_blocks" {
  description = "Entire CIDR block range"
  default     = "0.0.0.0/0"
}

variable "vpc_subnet" {
  description = "The subnet of the VPC being created in CIDR format"
  default     = "10.175.60.0/23"
}

variable "vpc_name" {
  description = "The name of the VPC being created"
  default     = "MYKYTENKO-DP"
}

variable "vpc_phz_domain" {
  description = "The private hosted zone domain name"
  default     = "mykytenko.vpc.local"
}

variable "vpc_availability_zones" {
  description = "The AZs that the VPC will use"
  default     = "us-east-1a,us-east-1b"
}

variable "vpc_public_subnets" {
  description = "The CIDR blocks to be used for the public subnets"
  default     = "10.175.60.0/25,10.173.54.128/25"
}

variable "vpc_private_subnets" {
  description = "The CIDR blocks to be used for the private subnets"
  default     = "10.175.60.0/25,10.173.55.128/25"
}

variable "vpc_environment_tag" {
  description = "The environment this VPC is for"
  default     = "dp"
}

variable "vpc_contact_tag" {
  description = "Who should be contacted with any queries relating to this VPC. This should be a valid email address"
  default     = "alexandr.mykytenko@gmail.com"
}

variable "vpc_virtual_private_gateway" {
  description = "The virtual private gateway id to propagate through the routing tables"
  default     = ""
}
