#-------------------------------------------------------------
# Set up Route53 record for our public ELB
#-------------------------------------------------------------
# Parse the route53 zone
/*
data "aws_route53_zone" "jenkins_elb_zone" {
  zone_id = "${var.jenkins_dns_zone}"
}

resource "aws_route53_record" "jenkins_elb_entry" {
  zone_id = "${data.aws_route53_zone.jenkins_elb_zone.zone_id}"
  name    = "jenkins-${var.jenkins_environment}.${data.aws_route53_zone.jenkins_elb_zone.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elb.jenkins_elb.dns_name}"]
}
*/