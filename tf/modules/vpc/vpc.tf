#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_subnet}"
  enable_dns_hostnames = true

  tags {
    Name    = "${var.vpc_name}"
    Env     = "${var.vpc_environment_tag}"
    Contact = "${var.vpc_contact_tag}"
  }
}
