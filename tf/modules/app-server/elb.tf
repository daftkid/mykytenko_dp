#--------------------------------------------------------------
# Jenkins Load Balancer
#--------------------------------------------------------------
resource "aws_elb" "app_server_elb" {
  name            = "${var.app_server_elb_name}-${var.app_server_environment}"
  subnets         = ["${split(",", var.app_server_elb_subnets)}"]
  security_groups = ["${aws_security_group.jenkins_elb_sg.id}"]

  listener {
    instance_port      = 8080
    instance_protocol  = "http"
    lb_port            = "${var.app_server_elb_enable_https? "443" : "80"}"
    lb_protocol        = "${var.app_server_elb_enable_https? "https" : "http"}"
    ssl_certificate_id = "${var.app_server_elb_enable_https? var.app_server_elb_https_cert : ""}"
  }

  health_check {
    interval            = "${var.app_server_elb_health_interval}"
    healthy_threshold   = "${var.app_server_elb_healthy_threshold}"
    unhealthy_threshold = "${var.app_server_elb_unhealthy_threshold}"
    target              = "TCP:8080"
    timeout             = 5
  }

  access_logs {
    bucket        = "${var.app_server_elb_log_bucket}"
    interval      = "${var.app_server_elb_log_interval}"
    bucket_prefix = "${var.app_server_elb_log_prefix}"
  }

  connection_draining_timeout = 60
  connection_draining         = true
  cross_zone_load_balancing   = true
  idle_timeout                = "${var.app_server_elb_idle_timeout}"

  tags {
    Name         = "${var.app_server_elb_name}-${var.app_server_environment}"
    contact      = "${var.app_server_contact}"
    environment  = "${var.app_server_environment}"
    role         = "Jenkins"
    created_with = "Terraform"
  }
}
