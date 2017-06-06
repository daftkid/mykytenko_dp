output "jenkins_public_dns" {
  value = "${aws_route53_record.jenkins_elb_entry.fqdn}"
}

output "jenkins_public_url" {
  value = "${var.jenkins_elb_enable_https? "https" : "http" }://${aws_route53_record.jenkins_elb_entry.fqdn}"
}

output "jenkins_asg_sg" {
  value = "${aws_security_group.jenkins_asg_sg.id}"
}

output "jenkins_elb_sg" {
  value = "${aws_security_group.jenkins_elb_sg.id}"
}

output "jenkins_instance_profile_arn" {
  value = "${aws_iam_instance_profile.jenkins_profile.arn}"
}

output "jenkins_instance_profile_role_arn" {
  value = "${aws_iam_role.jenkins_role.arn}"
}
