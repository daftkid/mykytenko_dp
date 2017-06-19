#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "webapp_account_number" {
  description = "ID of the account where we're setting up webapp"
  default     = "676206752786"
}

variable "webapp_region" {
  description = "The AWS region in which to deploy the bastion infrastructure."
  default     = "us-east-1"
}

variable "webapp_vpc_id" {
  description = "The VPC ID in which to deploy the bastion infrastructure."
}

#--------------------------------------------------------------
# Generic Variables
#--------------------------------------------------------------
variable "webapp_contact" {
  description = "The contact to assign to resources."
  default     = "alexandr.mykytenko@gmail.com"
}

variable "webapp_environment" {
  description = "The environment label to apply to webapp resources."
  default     = "dp"
}

variable "webapp_instance_tier" {
  description = "The puppet hiera tier to assign to the webapp host."
  default     = "prod"
}

variable "webapp_instance_role" {
  description = "The puppet hiera role to assign to the webapp host."
  default     = "webapp_server"
}

variable "webapp_trusted_networks" {
  description = "Comma-separated list of trusted networks in CIDR notation - can access ELB on port 80 and 29418"
  default     = "0.0.0.0/0"
}

variable "webapp_user" {
  description = "The user name that should be used when connecting to the webapp host."
  default     = "ec2-user"
}

variable "webapp_https_cert_name" {
  description = "Name of the certificate that we will use for https on webapp listener"
  default     = "mykytenko-cert"
}

#--------------------------------------------------------------
# Elastic File System Group Variables
#--------------------------------------------------------------
variable "webapp_rds_subnets" {
  type        = "string"
  description = "Comma-separated list of subnet IDs in which we will launch our RDS to save webapp data"
}

variable "webapp_rds_root_username" {
  type        = "string"
  description = "Username of root user on the RDS instance"
  default     = "root"
}

variable "webapp_rds_root_password" {
  type        = "string"
  description = "Password of root user on the RDS instance"
  default     = "yV3BFunH6rVkmGgbsM7B"
}

variable "webapp_rds_instance_type" {
  type        = "string"
  description = "Instance type of webapp RDS"
  default     = "db.t2.micro"
}

variable "webapp_rds_port" {
  type        = "string"
  description = "On what port should the RDS instance of webapp listen"
  default     = "5432"
}

variable "webapp_rds_storage" {
  type        = "string"
  description = "Size of the storage disk of Postgres RDS instance"
  default     = "20"
}

#--------------------------------------------------------------
# RDS Instance Variables
#--------------------------------------------------------------
variable "webapp_efs_subnets" {
  type        = "string"
  description = "Comma-separated list of subnet IDs in which we will launch our EFS mount target"
  default     = "subnet-3ff97f12,subnet-462b5a0f"
}

variable "webapp_efs_performance_mode" {
  type        = "string"
  description = "Performance mode of the EFS mount for webapp"
  default     = "maxIO"
}

#--------------------------------------------------------------
# Autoscaling Group Variables
#--------------------------------------------------------------
variable "webapp_asg_subnets" {
  description = "Comma-separated list of subnet IDs in which the ASG should launch resources."
  default     = "subnet-3ff97f12,subnet-462b5a0f"
}

variable "webapp_asg_grace_period" {
  description = "The number of seconds to wait after instance launch before starting health checks."
  default     = 3000
}

variable "webapp_asg_name" {
  description = "The name to assign to the autoscaling group."
  default     = "webapp"
}

#--------------------------------------------------------------
# Launch Configuration Variables
#--------------------------------------------------------------
variable "webapp_keypair" {
  description = "The name of the Aws keypair to use when launching instances."
  default     = "MYKYTENKO-KEYPAIR"
}

variable "webapp_ami" {
  description = "The ami_id to use for the webapp host."
  default     = "ami-6d1c2007"
}

variable "webapp_instance_type" {
  description = "The instance type to deploy for webapp instances."
  default     = "t2.micro"
}

variable "webapp_bastion_asg_sg" {
  description = "ID of the Security group of Bastion instance"
}

#--------------------------------------------------------------
# Load Balancing Variables
#--------------------------------------------------------------
variable "webapp_elb_log_bucket" {
  description = "The S3 bucket name where ELB access logs will be sent."
  default     = "mykytenko-dp-logs"
}

variable "webapp_elb_subnets" {
  description = "Comma-separated list of subnet IDs in which the ELB should be launched."
  default     = "subnet-18f97f35,subnet-cf285986"
}

variable "webapp_elb_health_interval" {
  description = "The interval in seconds between ELB health checks."
  default     = 15
}

variable "webapp_elb_healthy_threshold" {
  description = "The ELB health check threshold for marking instances healthy."
  default     = 3
}

variable "webapp_elb_idle_timeout" {
  description = "The amount of time in seconds an idle connection should stay open."
  default     = 600
}

variable "webapp_elb_log_interval" {
  description = "The ELB access log publishing interval in minutes."
  default     = 60
}

variable "webapp_elb_log_prefix" {
  description = "The S3 bucket prefix for storing ELB logs."
  default     = "webapp-elb-logs"
}

variable "webapp_elb_name" {
  description = "The name to assign to the ELB resource."
  default     = "webapp-elb"
}

variable "webapp_elb_unhealthy_threshold" {
  description = "The ELB health check threshold for marking instances unhealthy."
  default     = 3
}

#--------------------------------------------------------------
# S3 bucket variables
#--------------------------------------------------------------
variable "webapp_s3_move_to_ia_threshold" {
  type        = "string"
  description = "Threshold when we move log data to IA class"
  default     = "30"
}

variable "webapp_s3_move_to_glacier_threshold" {
  type        = "string"
  description = "Threshold when we move log data to Glacier class"
  default     = "90"
}

variable "webapp_s3_expiration_threshold" {
  type        = "string"
  description = "Threshold when we remove the logs from S3 bucket"
  default     = "365"
}

#--------------------------------------------------------------
# ELB DNS variables
#--------------------------------------------------------------
variable "webapp_dns_zone" {
  type        = "string"
  description = "Route53 hosted zone in which you would want to create DNS record to point to our ELB"
  default     = "mykytenko-dp.com"
}

variable "webapp_elb_enable_https" {
  description = "The ELB access log publishing interval in minutes."
  default     = false
}
