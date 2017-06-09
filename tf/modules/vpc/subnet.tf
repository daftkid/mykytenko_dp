#--------------------------------------------------------------
# Public subnet resource definition
#--------------------------------------------------------------
resource "aws_subnet" "public_subnets" {
  count                   = "${length(split(",", var.vpc_public_subnets))}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(split(",", var.vpc_public_subnets), count.index)}"
  availability_zone       = "${element(split(",", var.vpc_availability_zones), count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name    = "${var.vpc_name}.public.${element(split(",", var.vpc_availability_zones), count.index)}"
    Env     = "${var.vpc_environment_tag}"
    Role    = "public_subnet"
    Contact = "${var.vpc_contact_tag}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#--------------------------------------------------------------
# Private subnet resource definition
#--------------------------------------------------------------
resource "aws_subnet" "private_subnets" {
  count                   = "${length(split(",", var.vpc_private_subnets))}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(split(",", var.vpc_private_subnets), count.index)}"
  availability_zone       = "${element(split(",", var.vpc_availability_zones), count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name    = "${var.vpc_name}.private.${element(split(",", var.vpc_availability_zones), count.index)}"
    Env     = "${var.vpc_environment_tag}"
    Role    = "private_subnet"
    Contact = "${var.vpc_contact_tag}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
