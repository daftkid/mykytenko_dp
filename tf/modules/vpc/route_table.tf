#--------------------------------------------------------------
# Routing table for private subnets
#--------------------------------------------------------------
resource "aws_route_table" "private_route_table" {
  count            = "${length(split(",", var.global_private_subnets))}"
  vpc_id           = "${aws_vpc.main.id}"
  propagating_vgws = ["${compact(split(",", replace(var.vpc_virtual_private_gateway, " ", "")))}"]

  tags {
    Name        = "Private route table ${count.index}"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
    role        = "Private Routing Table"
  }
}

#--------------------------------------------------------------
# Route for private routing table
#--------------------------------------------------------------
resource "aws_route" "private_route" {
  count                  = "${length(split(",", var.global_private_subnets))}"
  route_table_id         = "${element(aws_route_table.private_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
}

#--------------------------------------------------------------
# Association between private subnets and route tables
#--------------------------------------------------------------
resource "aws_route_table_association" "private_rt_assoc" {
  count          = "${length(split(",", var.global_private_subnets))}"
  subnet_id      = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
}

#--------------------------------------------------------------
# Routing table for public subnets
#--------------------------------------------------------------
resource "aws_route_table" "public_route_table" {
  count            = "${length(split(",", var.global_public_subnets))}"
  vpc_id           = "${aws_vpc.main.id}"
  propagating_vgws = ["${compact(split(",", replace(var.vpc_virtual_private_gateway, " ", "")))}"]

  tags {
    Name        = "Public route table ${count.index}"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
    role        = "Public Routing Table"
  }
}

#--------------------------------------------------------------
# Route for public routing table
#--------------------------------------------------------------
resource "aws_route" "public_route" {
  count                  = "${length(split(",", var.global_public_subnets))}"
  route_table_id         = "${element(aws_route_table.public_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

#--------------------------------------------------------------
# Association between public subnets and route tables
#--------------------------------------------------------------
resource "aws_route_table_association" "public_rt_assoc" {
  count          = "${length(split(",", var.global_public_subnets))}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_route_table.*.id, count.index)}"
}
