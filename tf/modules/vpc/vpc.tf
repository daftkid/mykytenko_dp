#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_subnet}"
  enable_dns_hostnames = true

  tags {
    Name        = "${var.vpc_name}"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
  }
}
