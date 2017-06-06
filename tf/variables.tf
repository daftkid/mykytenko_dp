#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "global_account_number" {}

variable "global_work_profile" {}

variable "global_availability_zones" {}

variable "global_contact_tag" {}

variable "global_environment_tag" {}

variable "global_keypair" {}

variable "global_logging_bucket" {}

variable "global_private_subnets" {}

variable "global_product_tag" {}

variable "global_provider_role" {
  default = ""
}

variable "global_public_subnets" {}

variable "global_region" {}

#---------------------------------------------------------------
# Production VPC (Name: exampleproduct-prod, Region: us-east-1)
#---------------------------------------------------------------
variable "vpc_name" {}

variable "vpc_subnet" {}

#----------------------------------------------------------------
# Bastion Infrastructure (Name: bastion-prod, Region: us-east-1)
#----------------------------------------------------------------
variable "bastion_ami" {
  type = "map"
}