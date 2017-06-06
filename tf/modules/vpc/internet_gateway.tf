#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name        = "${var.vpc_name} Internet Gateway"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
  }
}
