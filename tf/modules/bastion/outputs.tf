output "bastion_public_dns" {
  value = "${aws_elb.bastion_elb.dns_name}"
}

output "bastion_sg" {
  value = "${aws_security_group.bastion_sg.id}"
}

output "bastion_source_sg" {
  value = "${aws_security_group.bastion_source_sg.id}"
}

output "bastion_user" {
  value = "${var.bastion_user}"
}

output "bastion_elb_zone_id" {
  value = "${aws_elb.bastion_elb.zone_id}"
}
