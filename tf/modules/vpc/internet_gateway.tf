#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name        = "${var.vpc_name} Internet Gateway"
    Env         = "${var.vpc_environment_tag}"
    Contact     = "${var.vpc_contact_tag}"
  }
}
