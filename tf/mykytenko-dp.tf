#------------------------------------------------------------------------------
# File: mykytenko-dp.tf
# Description: This is the root module for the account.
# This root module is responsible for managing environment infrastructure.
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

  vpc_availability_zones = "${var.global_availability_zones}"
  vpc_public_subnets     = "${var.global_public_subnets}"
  vpc_private_subnets    = "${var.global_private_subnets}"
  vpc_contact_tag        = "${var.global_contact_tag}"
  vpc_environment_tag    = "${var.global_environment_tag}"
  vpc_name               = "${var.vpc_name}"
  vpc_subnet             = "${var.vpc_subnet}"
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
  bastion_region           = "${var.global_region}"
  bastion_vpc_id           = "${module.vpc.vpc_id}"
  bastion_vpc_subnet       = "${module.vpc.vpc_cidr_block}"
  bastion_trusted_networks = "${var.global_trusted_cidr}"
}

# Set up app servers
module "webapp" {
  source = "./modules/webapp"

  webapp_ami              = "ami-6d1c2007"
  webapp_asg_subnets      = "${module.vpc.private_subnets}"
  webapp_instance_type    = "t2.medium"
  webapp_contact          = "${var.global_contact_tag}"
  webapp_elb_log_bucket   = "${var.global_logging_bucket}"
  webapp_elb_subnets      = "${module.vpc.public_subnets}"
  webapp_environment      = "${var.global_environment_tag}"
  webapp_trusted_networks = "${var.global_trusted_cidr}"
  webapp_bastion_asg_sg   = "${module.bastion.bastion_sg}"
  webapp_keypair          = "${var.global_keypair}"
  webapp_region           = "${var.global_region}"
  webapp_vpc_id           = "${module.vpc.vpc_id}"
  #webapp_dns_zone         = "${data.aws_route53_zone.main_zone.zone_id}"
  webapp_elb_enable_https = true
  #webapp_https_cert_name  = "${data.aws_acm_certificate.main_cert.arn}"
  webapp_rds_subnets      = "${module.vpc.private_subnets}"
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
  jenkins_trusted_networks = "${var.global_trusted_cidr}"
  jenkins_bastion_asg_sg   = "${module.bastion.bastion_sg}"
  jenkins_keypair          = "${var.global_keypair}"
  jenkins_region           = "${var.global_region}"
  jenkins_vpc_id           = "${module.vpc.vpc_id}"
  #jenkins_dns_zone         = "${data.aws_route53_zone.main_zone.zone_id}"
  jenkins_elb_enable_https = true
  #jenkins_elb_https_cert   = "${data.aws_acm_certificate.main_cert.arn}"
}