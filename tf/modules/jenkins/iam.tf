#--------------------------------------------------------------
# Jenkins Instance Profile
#--------------------------------------------------------------
resource "aws_iam_instance_profile" "jenkins_profile" {
  name  = "jenkins-profile-${var.jenkins_environment}-${var.global_region}"
  role = ["${aws_iam_role.jenkins_role.name}"]
}

#--------------------------------------------------------------
# Jenkins IAM Role
#--------------------------------------------------------------
resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-role-${var.jenkins_environment}-${var.global_region}"
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

#--------------------------------------------------------------
# Jenkins Policy to change files in the S3 bucket
#--------------------------------------------------------------
resource "aws_iam_role_policy" "jenkins_logging_policy" {
  name = "jenkins-logging-policy-${var.jenkins_environment}"
  role = "${aws_iam_role.jenkins_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": ["${aws_s3_bucket.jenkins_backup_bucket.arn}/*"]
    }
  ]
}
EOF
}
