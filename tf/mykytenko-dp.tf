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

  global_availability_zones   = "${var.global_availability_zones}"
  global_public_subnets       = "${var.global_public_subnets}"
  global_private_subnets      = "${var.global_private_subnets}"
  vpc_contact_tag             = "${var.global_contact_tag}"
  vpc_environment_tag         = "${var.global_environment_tag}"
  vpc_name                    = "${var.vpc_name}"
  vpc_product_tag             = "${var.global_product_tag}"
  vpc_subnet                  = "${var.vpc_subnet}"
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
  bastion_trusted_networks = "${var.global_trusted_cidr}"
}

# Set up app servers
module "app-server" {
  source = "./modules/app-server"

  app_server_ami              = "ami-6d1c2007"
  app_server_asg_subnets      = "${module.vpc.private_subnets}"
  app_server_instance_type    = "t2.medium"
  app_server_contact          = "${var.global_contact_tag}"
  app_server_elb_log_bucket   = "${var.global_logging_bucket}"
  app_server_elb_subnets      = "${module.vpc.public_subnets}"
  app_server_environment      = "${var.global_environment_tag}"
  app_server_trusted_networks = "${var.global_trusted_cidr}"
  app_server_bastion_asg_sg   = "${module.bastion.bastion_sg}"
  app_server_keypair          = "${var.global_keypair}"
  global_region               = "${var.global_region}"
  global_vpc_id               = "${module.vpc.vpc_id}"
  app_server_dns_zone         = "${data.aws_route53_zone.main_zone.zone_id}"
  app_server_elb_enable_https = true
  app_server_elb_https_cert   = "${data.aws_acm_certificate.main_cert.arn}"
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
  global_region            = "${var.global_region}"
  global_vpc_id            = "${module.vpc.vpc_id}"
  jenkins_dns_zone         = "${data.aws_route53_zone.main_zone.zone_id}"
  jenkins_elb_enable_https = true
  jenkins_elb_https_cert   = "${data.aws_acm_certificate.main_cert.arn}"
}