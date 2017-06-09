#-------------------------------------------------------------
# Set up Route53 record for our public ELB
#-------------------------------------------------------------
# Parse the route53 zone
data "aws_route53_zone" "webapp_elb_zone" {
  zone_id = "${var.webapp_dns_zone}"
}

resource "aws_route53_record" "webapp_elb_entry" {
  zone_id = "${data.aws_route53_zone.webapp_elb_zone.zone_id}"
  name    = "webapp-${var.webapp_environment}.${data.aws_route53_zone.webapp_elb_zone.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elb.webapp_elb.dns_name}"]
}
