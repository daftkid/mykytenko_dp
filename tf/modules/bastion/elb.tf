#--------------------------------------------------------------
# Bastion Load Balancer
#--------------------------------------------------------------
resource "aws_elb" "bastion_elb" {
  name            = "${var.bastion_elb_name}-${var.bastion_environment}"
  subnets         = ["${split(",", var.bastion_elb_subnets)}"]
  security_groups = ["${aws_security_group.bastion_elb_sg.id}"]

  listener {
    instance_port     = 22
    instance_protocol = "tcp"
    lb_port           = 22
    lb_protocol       = "tcp"
  }

  health_check {
    interval            = "${var.bastion_elb_health_interval}"
    healthy_threshold   = "${var.bastion_elb_healthy_threshold}"
    unhealthy_threshold = "${var.bastion_elb_unhealthy_threshold}"
    target              = "TCP:22"
    timeout             = 5
  }

  access_logs {
    bucket        = "${var.bastion_elb_log_bucket}"
    interval      = "${var.bastion_elb_log_interval}"
    bucket_prefix = "${var.bastion_elb_log_prefix}"
  }

  connection_draining_timeout = 60
  connection_draining         = true
  cross_zone_load_balancing   = true
  idle_timeout                = "${var.bastion_elb_idle_timeout}"

  tags {
    Name        = "${var.bastion_elb_name}-${var.bastion_environment}"
    contact     = "${var.bastion_contact}"
    product     = "${var.global_product}"
    environment = "${var.bastion_environment}"
    role        = "bastion"
  }
}
