# Set up WEBAPP in a VPC with EFS as file storage
# EFS to store file for highly availability
resource "aws_efs_file_system" "webapp_efs_fs" {
  creation_token   = "my-dp"
  performance_mode = "${var.webapp_efs_performance_mode}"

  tags {
    Contact = "${var.webapp_contact}"
    Name    = "Webapp_EFS"
  }
}

resource "aws_efs_mount_target" "webapp_efs_mt" {
  count           = 2
  file_system_id  = "${aws_efs_file_system.webapp_efs_fs.id}"
  subnet_id       = "${element(split(",", var.webapp_efs_subnets), count.index)}"
  security_groups = ["${aws_security_group.webapp_efs_mounttarget_sg.id}"]
}
