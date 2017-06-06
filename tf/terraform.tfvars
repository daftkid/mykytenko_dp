#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
global_account_number = "780640478506" # AWS account number.

global_work_profile = "mykytenko-dp-profile"

global_availability_zones = "us-east-1b,us-east-1c" # Comma-separated string.

global_contact_tag = "alexandr.mykytenko@gmail.com" # Email address for resource contact tag.

global_environment_tag = "dp" # The environment name.

global_keypair = "MYKYTENKO-DP-KEYPAIR" # AWS EC2 key pair name.

global_logging_bucket = "collected-logs-mykytenko-dp" # Name of logging bucket to use for ELB access logs.

global_private_subnets = "10.173.55.0/25,10.173.55.128/25" # Comma-separated list of subnets in CIDR notation.

global_product_tag = "Mykytenko-DP" # Short product name

global_public_subnets = "10.173.54.0/25,10.173.54.128/25" # Comma-separated list of subnets in CIDR notation.

global_region = "us-east-1" # The AWS region.

#---------------------------------------------------------------
# Production VPC (Name: exampleproduct-prod, Region: us-east-1)
#---------------------------------------------------------------
vpc_name = "MYKYTENKO-DP" # The name to associate with the VPC.

vpc_subnet = "10.173.54.0/23" # The VPC subnet in CIDR notation.

#----------------------------------------------------------------
# Bastion Infrastructure (Name: bastion-prod, Region: us-east-1)
#----------------------------------------------------------------
bastion_ami = {
  us-east-1 = "ami-6d1c2007" # The AMI to use when launching the bastion host.
}