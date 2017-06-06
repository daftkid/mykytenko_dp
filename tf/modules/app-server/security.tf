#--------------------------------------------------------------
# Jenkins ASG Security Group
#--------------------------------------------------------------
resource "aws_security_group" "jenkins_asg_sg" {
  name        = "jenkins-asg-sg-${var.jenkins_environment}"
  description = "Security group of the ASG containing jenkins instances"
  vpc_id      = "${var.global_vpc_id}"

  tags {
    product      = "${var.global_product}"
    contact      = "${var.jenkins_contact}"
    created_with = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_http_forward_ingress_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins_asg_sg.id}"
  source_security_group_id = "${aws_security_group.jenkins_elb_sg.id}"
}

resource "aws_security_group_rule" "allow_ssh_from_bastion_to_jenkins" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins_asg_sg.id}"
  source_security_group_id = "${var.jenkins_bastion_asg_sg}"
}

resource "aws_security_group_rule" "allow_egress_http_all" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_gerrit_git_all" {
  type              = "egress"
  from_port         = 29418
  to_port           = 29418
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_https_all" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_smtp_all" {
  type              = "egress"
  from_port         = 587
  to_port           = 587
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_ntp_all" {
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_gitssh_all" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_egress_prometheus" {
  type              = "egress"
  from_port         = 9091
  to_port           = 9091
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

#--------------------------------------------------------------
# jenkins ELB Security Group
#--------------------------------------------------------------
resource "aws_security_group" "jenkins_elb_sg" {
  name        = "jenkins-elb-sg-${var.jenkins_environment}"
  description = "Security group of the ELB to allow connection to jenkins instances"
  vpc_id      = "${var.global_vpc_id}"

  tags {
    product      = "${var.global_product}"
    contact      = "${var.jenkins_contact}"
    created_with = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_http_forward_egress_80" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_asg_sg.id}"
  security_group_id        = "${aws_security_group.jenkins_elb_sg.id}"
}

resource "aws_security_group_rule" "allow_http_or_https_access_to_elb" {
  type              = "ingress"
  from_port         = "${var.jenkins_elb_enable_https? "443" : "80"}"
  to_port           = "${var.jenkins_elb_enable_https? "443" : "80"}"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins_elb_sg.id}"
  cidr_blocks       = ["${split(",", var.jenkins_trusted_networks)}"]
}
