output "webapp_public_dns" {
  value = "${aws_elb.webapp_elb.dns_name}"
}