#--------------------------------------------------------------
# Private Hosted Forward Lookup Zone
#--------------------------------------------------------------
resource "aws_route53_zone" "vpc_private_zone" {
  name   = "${var.global_phz_domain}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
  }
}

#--------------------------------------------------------------
# Private Hosted Reverse Lookup Zone
#--------------------------------------------------------------
resource "aws_route53_zone" "reverse_lookup_zone" {
  name   = "${element(split(".", var.vpc_subnet),1)}.${element(split(".", var.vpc_subnet),0)}.in-addr.arpa"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${element(split(".", var.vpc_subnet),1)}.${element(split(".", var.vpc_subnet),0)}.in-addr.arpa"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
  }
}

#--------------------------------------------------------------
# Custom DHCP Option Set
#--------------------------------------------------------------
resource "aws_vpc_dhcp_options" "dp_options" {
  domain_name         = "${var.global_phz_domain}"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags {
    Name        = "dp_dhcp_options"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
  }
}

#--------------------------------------------------------------
# Association Between VPC and Custom DHCP Option Set
#--------------------------------------------------------------
resource "aws_vpc_dhcp_options_association" "local_resolver" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dp_options.id}"
}
