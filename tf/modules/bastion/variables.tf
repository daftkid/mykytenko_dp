#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "bastion_region" {
  description = "The AWS region in which to deploy the bastion infrastructure."
  default     = "us-east-1"
}

variable "bastion_vpc_subnet" {
  description = "The VPC subnet in CIDR notation."
  default     = "10.173.54.0/23"
}

variable "bastion_vpc_id" {
  description = "The VPC ID in which to deploy the bastion infrastructure."
}

#--------------------------------------------------------------
# Generic Variables
#--------------------------------------------------------------
variable "bastion_contact" {
  description = "The contact to assign to resources."
  default     = "alexandr.mykytenko@gmail.com"
}

variable "bastion_environment" {
  description = "The environment label to apply to bastion resources."
  default     = "dp"
}

variable "bastion_instance_tier" {
  description = "The puppet hiera tier to assign to the bastion host."
  default     = "dp"
}

variable "bastion_instance_role" {
  description = "The puppet hiera role to assign to the bastion host."
  default     = "bastion_server"
}

variable "bastion_puppet_environment" {
  description = "The puppet control environment the bastion host should be assigned to."
  default     = "master"
}

variable "bastion_trusted_networks" {
  description = "Comma-separated list of trusted networks in CIDR notation."
  default     = "0.0.0.0/0"
}

variable "bastion_user" {
  description = "The user name that should be used when connecting to the bastion host."
  default     = "admin"
}

#--------------------------------------------------------------
# Autoscaling Group Variables
#--------------------------------------------------------------
variable "bastion_asg_subnets" {
  description = "Comma-separated list of subnet IDs in which the ASG should launch resources."
}

variable "bastion_asg_grace_period" {
  description = "The number of seconds to wait after instance launch before starting health checks."
  default     = 30
}

variable "bastion_asg_name" {
  description = "The name to assign to the autoscaling group."
  default     = "bastion-asg"
}

#--------------------------------------------------------------
# Bastion CloudWatch Log Variables
#--------------------------------------------------------------
variable "bastion_logging_authlog" {
  description = "The path to the OS authentication log."
  default     = "/var/log/auth.log"
}

variable "bastion_logging_retention" {
  description = "The number of days to retain log events."
  default     = 60
}

variable "bastion_logging_syslog" {
  description = "The path to the OS syslog log."
  default     = "/var/log/messages"
}

#--------------------------------------------------------------
# Launch Configuration Variables
#--------------------------------------------------------------
variable "bastion_keypair" {
  description = "The name of the Aws keypair to use when launching instances."
}

variable "bastion_ami" {
  description = "Base AMI to use when launching bastion instances."

  default = {
    us-east-1      = "ami-4a12565d"
    us-west-1      = "ami-ed713f8d"
    us-west-2      = "ami-4e1cc32e"
    eu-west-1      = "ami-2897d35b"
    eu-central-1   = "ami-02f5096d"
    ap-southeast-1 = "ami-f610b595"
    ap-southeast-2 = "ami-8e97a7ed"
    ap-northeast-1 = "ami-1d5a877c"
    ap-northeast-2 = "ami-ba72a7d4"
  }
}

variable "bastion_instance_type" {
  description = "The instance type to deploy for bastion instances."
  default     = "t2.nano"
}

#--------------------------------------------------------------
# Load Balancing Variables
#--------------------------------------------------------------
variable "bastion_elb_log_bucket" {
  description = "The S3 bucket name where ELB access logs will be sent."
}

variable "bastion_elb_subnets" {
  description = "Comma-separated list of subnet IDs in which the ELB should be launched."
}

variable "bastion_elb_health_interval" {
  description = "The interval in seconds between ELB health checks."
  default     = 15
}

variable "bastion_elb_healthy_threshold" {
  description = "The ELB health check threshold for marking instances healthy."
  default     = 3
}

variable "bastion_elb_idle_timeout" {
  description = "The amount of time in seconds an idle connection should stay open."
  default     = 600
}

variable "bastion_elb_log_interval" {
  description = "The ELB access log publishing interval in minutes."
  default     = 60
}

variable "bastion_elb_log_prefix" {
  description = "The S3 bucket prefix for storing ELB logs."
  default     = "bastion-elb-logs"
}

variable "bastion_elb_name" {
  description = "The name to assign to the ELB resource."
  default     = "bastion-elb"
}

variable "bastion_elb_unhealthy_threshold" {
  description = "The ELB health check threshold for marking instances unhealthy."
  default     = 3
}
