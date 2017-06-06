#--------------------------------------------------------------
# Bastion Instance Profile
#--------------------------------------------------------------
resource "aws_iam_instance_profile" "bastion_profile" {
  name  = "bastion-profile-${var.bastion_environment}-${var.global_region}"
  role = ["${aws_iam_role.bastion_role.name}"]

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

#--------------------------------------------------------------
# Bastion IAM Role
#--------------------------------------------------------------
resource "aws_iam_role" "bastion_role" {
  name = "bastion-role-${var.bastion_environment}-${var.global_region}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
        },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}