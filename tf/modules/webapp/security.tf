#--------------------------------------------------------------
# webapp Elastic File System Mount Target Security Group
#--------------------------------------------------------------
resource "aws_security_group" "webapp_efs_mounttarget_sg" {
  name        = "webapp-efs-mt-sg-${var.webapp_environment}"
  description = "Allow connection from our webapp instance to our EFS mount targets"
  vpc_id      = "${var.webapp_vpc_id}"

  tags {
    contact      = "${var.webapp_contact}"
  }
}

resource "aws_security_group_rule" "allow_efs_mount_ingress_111" {
  type                     = "ingress"
  from_port                = 111
  to_port                  = 111
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_efs_mounttarget_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_asg_sg.id}"
}

resource "aws_security_group_rule" "allow_efs_mount_ingress_2049" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_efs_mounttarget_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_asg_sg.id}"
}

#--------------------------------------------------------------
# webapp RDS Security Group
#--------------------------------------------------------------
resource "aws_security_group" "webapp_rds_sg" {
  name        = "webapp-rds-sg-${var.webapp_environment}"
  description = "Allow connection from our webapp instance to our webapp RDS"
  vpc_id      = "${var.webapp_vpc_id}"

  tags {
    contact      = "${var.webapp_contact}"
  }
}

resource "aws_security_group_rule" "allow_rds_connection_ingress" {
  type                     = "ingress"
  from_port                = "${var.webapp_rds_port}"
  to_port                  = "${var.webapp_rds_port}"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_rds_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_asg_sg.id}"
}

#--------------------------------------------------------------
# webapp ASG Security Group
#--------------------------------------------------------------
resource "aws_security_group" "webapp_asg_sg" {
  name        = "webapp-asg-sg-${var.webapp_environment}"
  description = "Security group of the ASG containing webapp instances"
  vpc_id      = "${var.webapp_vpc_id}"

  tags {
    contact      = "${var.webapp_contact}"
  }
}

resource "aws_security_group_rule" "allow_efs_mount_egress_111" {
  type                     = "egress"
  from_port                = 111
  to_port                  = 111
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_asg_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_efs_mounttarget_sg.id}"
}

resource "aws_security_group_rule" "allow_efs_mount_egress_2049" {
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_asg_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_efs_mounttarget_sg.id}"
}

resource "aws_security_group_rule" "allow_ntp_egress_123_all" {
  type                     = "egress"
  from_port                = 123
  to_port                  = 123
  protocol                 = "udp"
  security_group_id        = "${aws_security_group.webapp_asg_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_efs_mounttarget_sg.id}"
}

resource "aws_security_group_rule" "allow_rds_connection_egress_5432" {
  type                     = "egress"
  from_port                = "${var.webapp_rds_port}"
  to_port                  = "${var.webapp_rds_port}"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_asg_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_rds_sg.id}"
}

resource "aws_security_group_rule" "allow_http_forward_ingress_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_asg_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_elb_sg.id}"
}

resource "aws_security_group_rule" "allow_webapp_git_forward_ingress" {
  type                     = "ingress"
  from_port                = "${var.webapp_git_port}"
  to_port                  = "${var.webapp_git_port}"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_asg_sg.id}"
  source_security_group_id = "${aws_security_group.webapp_elb_sg.id}"
}

resource "aws_security_group_rule" "allow_ssh_from_bastion_to_webapp" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.webapp_asg_sg.id}"
  source_security_group_id = "${var.webapp_bastion_asg_sg}"
}

resource "aws_security_group_rule" "allow_egress_http_all" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.webapp_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_https_all" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.webapp_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_smtp_all" {
  type              = "egress"
  from_port         = 587
  to_port           = 587
  protocol          = "tcp"
  security_group_id = "${aws_security_group.webapp_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

#--------------------------------------------------------------
# webapp ELB Security Group
#--------------------------------------------------------------
resource "aws_security_group" "webapp_elb_sg" {
  name        = "webapp-elb-sg-${var.webapp_environment}"
  description = "Security group of the ELB to allow connection to webapp instances"
  vpc_id      = "${var.webapp_vpc_id}"

  tags {
    contact      = "${var.webapp_contact}"
  }
}

resource "aws_security_group_rule" "allow_webapp_git_forward_egress" {
  type                     = "egress"
  from_port                = "${var.webapp_git_port}"
  to_port                  = "${var.webapp_git_port}"
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.webapp_asg_sg.id}"
  security_group_id        = "${aws_security_group.webapp_elb_sg.id}"
}

resource "aws_security_group_rule" "allow_http_forward_egress_80" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.webapp_asg_sg.id}"
  security_group_id        = "${aws_security_group.webapp_elb_sg.id}"
}

resource "aws_security_group_rule" "allow_http_access_to_elb_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.webapp_elb_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https_access_to_elb_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.webapp_elb_sg.id}"
  cidr_blocks       = ["${split(",", var.webapp_trusted_networks)}"]
}

resource "aws_security_group_rule" "allow_webapp_git_access_to_elb" {
  type              = "ingress"
  from_port         = "${var.webapp_git_port}"
  to_port           = "${var.webapp_git_port}"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.webapp_elb_sg.id}"
  cidr_blocks       = ["${split(",", var.webapp_trusted_networks)}"]
}
