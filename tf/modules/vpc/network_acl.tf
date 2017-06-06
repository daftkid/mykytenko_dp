#--------------------------------------------------------------
# Private Subnet Network ACL
#--------------------------------------------------------------
resource "aws_network_acl" "private" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.private_subnets.*.id}"]

  tags {
    Name        = "private-acl"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
    role        = "Private Subnet ACL"
  }
}

# Authorize all inbound traffic.
resource "aws_network_acl_rule" "allow_ingress_all" {
  egress         = false
  protocol       = "all"
  rule_number    = 100
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 0
  to_port        = 0
  network_acl_id = "${aws_network_acl.private.id}"
}

# Authorize all outbound traffic.
resource "aws_network_acl_rule" "allow_egress_all" {
  egress         = true
  protocol       = "all"
  rule_number    = 100
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 0
  to_port        = 0
  network_acl_id = "${aws_network_acl.private.id}"
}

#--------------------------------------------------------------
# Public Subnet Network ACL
#--------------------------------------------------------------
resource "aws_network_acl" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.public_subnets.*.id}"]

  tags {
    Name        = "public-acl"
    environment = "${var.vpc_environment_tag}"
    product     = "${var.vpc_product_tag}"
    contact     = "${var.vpc_contact_tag}"
    role        = "Public Subnet ACL"
  }
}

#--------------------------------------------------------------
# Public Subnet Network ACL - Ingress Rules
#--------------------------------------------------------------
resource "aws_network_acl_rule" "allow_ingress_http" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "allow_ingress_https" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "allow_ingress_icmp" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 300
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = -1
  to_port        = -1
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "allow_ingress_ntp" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 350
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 123
  to_port        = 123
}

resource "aws_network_acl_rule" "allow_ingress_ntp_ephemeral" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 360
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "allow_ingress_ephemeral" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 400
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.vpc_subnet}"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "allow_ingress_ssh_vpc" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 800
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.vpc_subnet}"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "block_ingress_mysql" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 1100
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 3306
  to_port        = 3306
}

resource "aws_network_acl_rule" "block_ingress_postgres" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 1200
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 5432
  to_port        = 5432
}

resource "aws_network_acl_rule" "allow_ingress_ephemeral2" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 1400
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 1024
  to_port        = 65535
}

#--------------------------------------------------------------
# Public Subnet Network ACL - Egress Rules
#--------------------------------------------------------------
resource "aws_network_acl_rule" "allow_egress_ephemeral" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "allow_egress_http" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "allow_egress_https" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 300
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "allow_egress_ssh_vpc" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 400
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.vpc_subnet}"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "allow_egress_icmp" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 500
  egress         = true
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = -1
  to_port        = -1
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "allow_egress_ntp" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 550
  egress         = true
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 123
  to_port        = 123
}

resource "aws_network_acl_rule" "allow_egress_ntp_ephemeral" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 560
  egress         = true
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "allow_egress_ssh_all" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number    = 700
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.all_cidr_blocks}"
  from_port      = 22
  to_port        = 22
}
