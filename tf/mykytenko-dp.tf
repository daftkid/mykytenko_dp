#------------------------------------------------------------------------------
# File: mykytenko-dp.tf
# Description: This is the root module for the account.
# This root module is responsible for managing environment
# infrastructure.
#
# ALL INFRASTUCTURE SHOULD BE MANAGED USING MODULES, NO DIRECT RESOURCE
# DECLARATIONS SHOULD EVER BE PRESENT IN THIS FILE.
#------------------------------------------------------------------------------
provider "aws" {
  allowed_account_ids = ["${var.global_account_number}"]
  region              = "${var.global_region}"
  profile             = "${var.global_work_profile}"
}

#-------------------------------------------------------------
# Production VPC (Name: exampleproduct-prod, Region: us-east-1)
#-------------------------------------------------------------
module "vpc" {
  source = "./modules/vpc"

  global_availability_zones   = "${var.global_availability_zones}"
  global_elsevier_cidr_blocks = "${var.global_elsevier_cidr_blocks}"
  global_public_subnets       = "${var.global_public_subnets}"
  global_private_subnets      = "${var.global_private_subnets}"
  vpc_contact_tag             = "${var.global_contact_tag}"
  vpc_environment_tag         = "${var.global_environment_tag}"
  vpc_name                    = "${var.vpc_name}"
  vpc_product_tag             = "${var.global_product_tag}"
  vpc_subnet                  = "${var.vpc_subnet}"
}

# Add missing entries to the network ACL in our VPC
module "more_acl" {
  source = "./modules/nacl"

  public_acl_id = "acl-c2bc3aa4"
  source_cidrs  = "0.0.0.0/0"
}

#-----------------------------------------------------------------
# Bastion Infrastructure (Name: bastion-prod, Region: us-east-1)
#-----------------------------------------------------------------
module "bastion" {
  source = "./modules/bastion"

  bastion_ami              = "${var.bastion_ami}"
  bastion_asg_subnets      = "${module.vpc.private_subnets}"
  bastion_contact          = "${var.global_contact_tag}"
  bastion_elb_log_bucket   = "${var.global_logging_bucket}"
  bastion_elb_subnets      = "${module.vpc.public_subnets}"
  bastion_environment      = "${var.global_environment_tag}"
  bastion_keypair          = "${var.global_keypair}"
  global_region            = "${var.global_region}"
  global_vpc_id            = "${module.vpc.vpc_id}"
  global_vpc_subnet        = "${module.vpc.vpc_cidr_block}"
  bastion_trusted_networks = "${var.global_epam_cidr_block},178.124.171.118/32"
}

# Set up Gerrit system
module "gerrit" {
  source = "./modules/gerrit"

  global_account_number         = "${var.global_account_number}"
  gerrit_ami                    = "ami-c481fad3"
  gerrit_asg_subnets            = "${module.vpc.private_subnets}"
  gerrit_instance_type          = "t2.medium"
  gerrit_contact                = "${var.global_contact_tag}"
  gerrit_elb_log_bucket         = "${var.global_logging_bucket}"
  gerrit_elb_subnets            = "${module.vpc.public_subnets}"
  gerrit_efs_subnets            = "${module.vpc.private_subnets}"
  gerrit_rds_subnets            = "${module.vpc.private_subnets}"
  gerrit_rds_instance_type      = "db.t2.medium"
  gerrit_environment            = "${var.global_environment_tag}"
  gerrit_bastion_asg_sg         = "${module.bastion.bastion_sg}"
  gerrit_keypair                = "${var.global_keypair}"
  gerrit_https_certificate_name = "sr-signoff.ets-cloud.com"
  gerrit_trusted_networks       = "${var.global_epam_cidr_block},${join(",", formatlist("%s/32", split(",", module.vpc.nat_eips)))},${var.epam_minsk_cidr_blocks},${var.elsevier_cidrs_for_gerrit},52.2.116.88/32,${var.elsevier_danish_offices}"
  global_region                 = "${var.global_region}"
  global_vpc_id                 = "${module.vpc.vpc_id}"
}

# Set up Jenkins CICD tool
module "jenkins" {
  source = "./modules/jenkins"

  jenkins_ami              = "ami-6d1c2007"
  jenkins_asg_subnets      = "${module.vpc.private_subnets}"
  jenkins_instance_type    = "t2.medium"
  jenkins_contact          = "${var.global_contact_tag}"
  jenkins_elb_log_bucket   = "${var.global_logging_bucket}"
  jenkins_elb_subnets      = "${module.vpc.public_subnets}"
  jenkins_environment      = "${var.global_environment_tag}"
  jenkins_trusted_networks = "${var.global_epam_cidr_block},${var.epam_minsk_cidr_blocks}"
  jenkins_bastion_asg_sg   = "${module.bastion.bastion_sg}"
  jenkins_keypair          = "${var.global_keypair}"
  global_region            = "${var.global_region}"
  global_vpc_id            = "${module.vpc.vpc_id}"
  jenkins_dns_zone         = "${data.aws_route53_zone.main_zone.zone_id}"
  jenkins_elb_enable_https = true
  jenkins_elb_https_cert   = "${data.aws_acm_certificate.main_cert.arn}"
}