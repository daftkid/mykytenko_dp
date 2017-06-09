#---------------------------------------------------------------
# Jenkins Autoscaling Group
#---------------------------------------------------------------
resource "aws_autoscaling_group" "jenkins_asg" {
  name                      = "${var.jenkins_asg_name}-${var.jenkins_environment}"
  vpc_zone_identifier       = ["${split(",", var.jenkins_asg_subnets)}"]
  launch_configuration      = "${aws_launch_configuration.jenkins_lc.id}"
  max_size                  = 1
  min_size                  = 1
  health_check_type         = "EC2"
  load_balancers            = ["${aws_elb.jenkins_elb.name}"]
  health_check_grace_period = "${var.jenkins_asg_grace_period}"

  tag {
    key                 = "Role"
    value               = "jenkins"
    propagate_at_launch = true
  }

  tag {
    key                 = "Env"
    value               = "${var.jenkins_environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Contact"
    value               = "${var.jenkins_contact}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "Jenkins-${var.jenkins_environment}"
    propagate_at_launch = true
  }
}

#---------------------------------------------------------------
# Jenkins Autoscaling Launch Configuration
#---------------------------------------------------------------
resource "aws_launch_configuration" "jenkins_lc" {
  name_prefix          = "jenkins-lc-${var.jenkins_environment}"
  image_id             = "${var.jenkins_ami}"
  instance_type        = "${var.jenkins_instance_type}"
  key_name             = "${var.jenkins_keypair}"
  security_groups      = ["${aws_security_group.jenkins_asg_sg.id}"]
  user_data            = "${data.template_file.init.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.jenkins_profile.id}"

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = true
  }
}
