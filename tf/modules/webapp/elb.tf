#--------------------------------------------------------------
# Webapp Load Balancer
#--------------------------------------------------------------
resource "aws_elb" "webapp_elb" {
  name            = "${var.webapp_elb_name}-${var.webapp_environment}"
  subnets         = ["${split(",", var.webapp_elb_subnets)}"]
  security_groups = ["${aws_security_group.webapp_elb_sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::${var.webapp_account_number}:server-certificate/mykytenko-dp.com"
  }

  health_check {
    interval            = "${var.webapp_elb_health_interval}"
    healthy_threshold   = "${var.webapp_elb_healthy_threshold}"
    unhealthy_threshold = "${var.webapp_elb_unhealthy_threshold}"
    target              = "TCP:80"
    timeout             = 5
  }

  access_logs {
    bucket        = "${var.webapp_elb_log_bucket}"
    interval      = "${var.webapp_elb_log_interval}"
    bucket_prefix = "${var.webapp_elb_log_prefix}"
  }

  connection_draining_timeout = 60
  connection_draining         = true
  cross_zone_load_balancing   = true
  idle_timeout                = "${var.webapp_elb_idle_timeout}"

  tags {
    Name    = "${var.webapp_elb_name}-${var.webapp_environment}"
    Contact = "${var.webapp_contact}"
    Env     = "${var.webapp_environment}"
    Role    = "Webapp"
  }
}
