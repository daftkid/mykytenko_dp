#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "global_region" {
  description = "The AWS region in which to deploy the bastion infrastructure."
}

variable "global_vpc_id" {
  description = "The VPC ID in which to deploy the bastion infrastructure."
}

variable "global_product" {
  description = "The name of the product which is being deployed."
  default     = "epam"
}

#--------------------------------------------------------------
# Generic Variables
#--------------------------------------------------------------
variable "jenkins_contact" {
  description = "The contact to assign to resources."
  default     = "Manh_Tan_Nguyen@epam.com"
}

variable "jenkins_environment" {
  description = "The environment label to apply to jenkins resources."
  default     = "PROD"
}

variable "jenkins_trusted_networks" {
  description = "Comma-separated list of trusted networks in CIDR notation - can access ELB on port 80 and 29418"
  default     = "0.0.0.0/0"
}

#--------------------------------------------------------------
# Autoscaling Group Variables
#--------------------------------------------------------------
variable "jenkins_asg_subnets" {
  description = "Comma-separated list of subnet IDs in which the ASG should launch resources."
}

variable "jenkins_asg_grace_period" {
  description = "The number of seconds to wait after instance launch before starting health checks."
  default     = 3000
}

variable "jenkins_asg_name" {
  description = "The name to assign to the autoscaling group."
  default     = "JenkinsCI"
}

#--------------------------------------------------------------
# Launch Configuration Variables
#--------------------------------------------------------------
variable "jenkins_keypair" {
  description = "The name of the Aws keypair to use when launching instances."
  default     = "ELSAWS_EPAM_LAUNCH_20161007"
}

variable "jenkins_ami" {
  description = "The ami_id to use for the jenkins host."
}

variable "jenkins_instance_type" {
  description = "The instance type to deploy for jenkins instances."
  default     = "t2.micro"
}

variable "jenkins_bastion_asg_sg" {
  description = "ID of the Security group of Bastion instance"
}

#--------------------------------------------------------------
# Load Balancing Variables
#--------------------------------------------------------------
variable "jenkins_elb_log_bucket" {
  description = "The S3 bucket name where ELB access logs will be sent."
  default     = "collected-logs-epam-698099446200"
}

variable "jenkins_elb_subnets" {
  description = "Comma-separated list of subnet IDs in which the ELB should be launched."
  default     = "subnet-18f97f35,subnet-cf285986"
}

variable "jenkins_elb_health_interval" {
  description = "The interval in seconds between ELB health checks."
  default     = 15
}

variable "jenkins_elb_healthy_threshold" {
  description = "The ELB health check threshold for marking instances healthy."
  default     = 3
}

variable "jenkins_elb_idle_timeout" {
  description = "The amount of time in seconds an idle connection should stay open."
  default     = 600
}

variable "jenkins_elb_log_interval" {
  description = "The ELB access log publishing interval in minutes."
  default     = 60
}

variable "jenkins_elb_log_prefix" {
  description = "The S3 bucket prefix for storing ELB logs."
  default     = "jenkins-elb-logs"
}

variable "jenkins_elb_name" {
  description = "The name to assign to the ELB resource."
  default     = "jenkins-elb"
}

variable "jenkins_elb_unhealthy_threshold" {
  description = "The ELB health check threshold for marking instances unhealthy."
  default     = 3
}

variable "jenkins_elb_enable_https" {
  description = "Specify whether we should be using HTTPS on the Jenkins public ELB"
  default     = false
}

variable "jenkins_elb_https_cert" {
  description = "ARN of the certficate that we should use on the ELB if we enable https"
  default     = ""
}

#--------------------------------------------------------------
# S3 bucket variables
#--------------------------------------------------------------
variable "jenkins_s3_move_to_ia_threshold" {
  type        = "string"
  description = "Threshold when we move log data to IA class"
  default     = "30"
}

variable "jenkins_s3_move_to_glacier_threshold" {
  type        = "string"
  description = "Threshold when we move log data to Glacier class"
  default     = "90"
}

variable "jenkins_s3_expiration_threshold" {
  type        = "string"
  description = "Threshold when we remove the logs from S3 bucket"
  default     = "365"
}

variable "jenkins_s3_versioning" {
  type        = "string"
  description = "Enable versioning on S3 bucket to avoid deletion by human error"
  default     = "false"
}

#--------------------------------------------------------------
# ELB DNS variables
#--------------------------------------------------------------
variable "jenkins_dns_zone" {
  type        = "string"
  description = "Route53 hosted zone in which we would want to create DNS record to point to our ELB"
}
