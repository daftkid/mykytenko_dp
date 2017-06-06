variable "all_cidr_blocks" {
  description = "Entire CIDR block range"
  default     = "0.0.0.0/0"
}

variable "vpc_subnet" {
  description = "The subnet of the VPC being created in CIDR format"
}

variable "vpc_name" {
  description = "The name of the VPC being created"
}

variable "global_phz_domain" {
  description = "The private hosted zone domain name"
  default     = "mykytenko.vpc.local"
}

variable "global_availability_zones" {
  description = "The AZs that the VPC will use"
}

variable "global_public_subnets" {
  description = "The CIDR blocks to be used for the public subnets"
}

variable "global_private_subnets" {
  description = "The CIDR blocks to be used for the private subnets"
}

variable "vpc_environment_tag" {
  description = "The environment this VPC is for"
}

variable "vpc_product_tag" {
  description = "The product this VPC is for"
}

variable "vpc_contact_tag" {
  description = "Who should be contacted with any queries relating to this VPC. This should be a valid email address"
}

variable "vpc_virtual_private_gateway" {
  description = "The virtual private gateway id to propagate through the routing tables"
  default     = ""
}
