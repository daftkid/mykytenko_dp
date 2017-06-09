# Set up Oracle RDS instance to store webapp DB
resource "aws_db_instance" "webapprds" {
  allocated_storage      = "${var.webapp_rds_storage}"
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "9.5.4"
  instance_class         = "${var.webapp_rds_instance_type}"
  name                   = "webappRDS${var.webapp_environment}"
  port                   = "${var.webapp_rds_port}"
  username               = "${var.webapp_rds_root_username}"
  password               = "${var.webapp_rds_root_password}"
  db_subnet_group_name   = "${aws_db_subnet_group.webapp_rds_subnet_group.id}"
  parameter_group_name   = "${aws_db_parameter_group.webapp_rds_parameter_group.id}"
  vpc_security_group_ids = ["${aws_security_group.webapp_rds_sg.id}"]
}

resource "aws_db_subnet_group" "webapp_rds_subnet_group" {
  name       = "webapprds-subnetgroup-${var.webapp_environment}"
  subnet_ids = ["${split(",", var.webapp_rds_subnets)}"]

  tags {
    Contact = "${var.webapp_contact}"
    Env     = "${var.webapp_environment}"
    Role    = "webapp"
  }
}

resource "aws_db_parameter_group" "webapp_rds_parameter_group" {
  name   = "webapprds-params-${var.webapp_environment}"
  family = "postgres9.5"

  tags {
    Contact = "${var.webapp_contact}"
    Env     = "${var.webapp_environment}"
    Role    = "webapp"
  }
}
