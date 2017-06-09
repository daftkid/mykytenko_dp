data "template_file" "init" {
  template = "${file("${path.module}/templates/userdata.tpl")}"

  vars {
    # DB connection related
    rds_host     = "${aws_db_instance.webapprds.address}"
    rds_port     = "${var.webapp_rds_port}"
    rds_username = "${var.webapp_rds_root_username}"
    rds_password = "${var.webapp_rds_root_password}"

    # EFS mount related
    efs_targets = "${join(",", aws_efs_mount_target.webapp_efs_mt.*.dns_name)}"
    efs_fs_id   = "${aws_efs_file_system.webapp_efs_fs.id}"
  }
}
