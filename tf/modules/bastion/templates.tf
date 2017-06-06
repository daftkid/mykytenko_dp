#--------------------------------------------------------------
# Bastion User Data Template
#--------------------------------------------------------------
data "template_file" "init" {
  template = "${file("${path.module}/templates/userdata.tpl")}"

  vars {
    region              = "${var.global_region}"
    syslog_path         = "${var.bastion_logging_syslog}"
    authlog_path        = "${var.bastion_logging_authlog}"
    bastion_environment = "${var.bastion_environment}"
    instance_role       = "${var.bastion_instance_role}"
    instance_tier       = "${var.bastion_instance_tier}"
    puppet_environment  = "${var.bastion_puppet_environment}"
  }
}
