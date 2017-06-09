#---------------------------------------------------------------
# webapp Autoscaling Group
#---------------------------------------------------------------
resource "aws_autoscaling_group" "webapp_asg" {
  name                      = "${var.webapp_asg_name}-${var.webapp_environment}"
  vpc_zone_identifier       = ["${split(",", var.webapp_asg_subnets)}"]
  launch_configuration      = "${aws_launch_configuration.webapp_lc.id}"
  max_size                  = 1
  min_size                  = 1
  health_check_type         = "EC2"
  load_balancers            = ["${aws_elb.webapp_elb.name}"]
  health_check_grace_period = "${var.webapp_asg_grace_period}"

  tag {
    key                 = "Role"
    value               = "webapp"
    propagate_at_launch = true
  }

  tag {
    key                 = "Env"
    value               = "${var.webapp_environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Contact"
    value               = "${var.webapp_contact}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "webappCodeReview-${var.webapp_environment}"
    propagate_at_launch = true
  }
}

#---------------------------------------------------------------
# Bastion Autoscaling Launch Configuration
#-----------------------------------------webappCodeReview
resource "aws_launch_configuration" "webapp_lc" {
  name_prefix   = "webapp-lc-${var.webapp_environment}"
  image_id      = "${var.webapp_ami}"
  instance_type = "${var.webapp_instance_type}"

  /* iam_instance_profile = "${aws_iam_instance_profile.bastion_profile.id}" */
  key_name        = "${var.webapp_keypair}"
  security_groups = ["${aws_security_group.webapp_asg_sg.id}"]
  user_data       = "${data.template_file.init.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
