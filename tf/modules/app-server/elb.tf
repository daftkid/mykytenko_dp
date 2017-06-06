#--------------------------------------------------------------
# Jenkins Load Balancer
#--------------------------------------------------------------
resource "aws_elb" "jenkins_elb" {
  name            = "${var.jenkins_elb_name}-${var.jenkins_environment}"
  subnets         = ["${split(",", var.jenkins_elb_subnets)}"]
  security_groups = ["${aws_security_group.jenkins_elb_sg.id}"]

  listener {
    instance_port      = 8080
    instance_protocol  = "http"
    lb_port            = "${var.jenkins_elb_enable_https? "443" : "80"}"
    lb_protocol        = "${var.jenkins_elb_enable_https? "https" : "http"}"
    ssl_certificate_id = "${var.jenkins_elb_enable_https? var.jenkins_elb_https_cert : ""}"
  }

  health_check {
    interval            = "${var.jenkins_elb_health_interval}"
    healthy_threshold   = "${var.jenkins_elb_healthy_threshold}"
    unhealthy_threshold = "${var.jenkins_elb_unhealthy_threshold}"
    target              = "TCP:8080"
    timeout             = 5
  }

  access_logs {
    bucket        = "${var.jenkins_elb_log_bucket}"
    interval      = "${var.jenkins_elb_log_interval}"
    bucket_prefix = "${var.jenkins_elb_log_prefix}"
  }

  connection_draining_timeout = 60
  connection_draining         = true
  cross_zone_load_balancing   = true
  idle_timeout                = "${var.jenkins_elb_idle_timeout}"

  tags {
    Name         = "${var.jenkins_elb_name}-${var.jenkins_environment}"
    contact      = "${var.jenkins_contact}"
    product      = "${var.global_product}"
    environment  = "${var.jenkins_environment}"
    role         = "Jenkins"
    created_with = "Terraform"
  }
}
