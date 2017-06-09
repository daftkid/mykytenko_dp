#--------------------------------------------------------------
# webapp Instance Profile
#--------------------------------------------------------------
resource "aws_iam_instance_profile" "webapp_profile" {
  name  = "webapp-profile-${var.webapp_environment}-${var.webapp_region}"
  role = "${aws_iam_role.webapp_role.name}"

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

#--------------------------------------------------------------
# webapp IAM Role
#--------------------------------------------------------------
resource "aws_iam_role" "webapp_role" {
  name = "webapp-role-${var.webapp_environment}-${var.webapp_region}"
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
# webapp Backup Policy
#--------------------------------------------------------------
resource "aws_iam_role_policy" "webapp_backup_policy" {
  name = "webapp-backup-policy-${var.webapp_environment}"
  role = "${aws_iam_role.webapp_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["${aws_s3_bucket.webapp_backup_bucket.arn}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:ListMultipartUploadParts",
        "s3:ListBucketMultipartUploads",
        "s3:AbortMultipartUpload"
      ],
      "Resource": ["${aws_s3_bucket.webapp_backup_bucket.arn}/*"]
    }
  ]
}
EOF
}
