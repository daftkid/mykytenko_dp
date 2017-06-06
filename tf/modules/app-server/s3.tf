#--------------------------------------------------------------
# An S3 bucket to hold files from Jenkins
#--------------------------------------------------------------
resource "aws_s3_bucket" "jenkins_backup_bucket" {
  bucket = "jenkins-backup-${var.jenkins_environment}-${var.global_region}"
  acl    = "private"

  tags {
    Name         = "jenkins-backup-${var.jenkins_environment}-${var.global_region}"
    Purpose      = "Host files from Jenkins instance"
    created_with = "Terraform"
  }

  lifecycle_rule {
    id      = "all"
    prefix  = "/"
    enabled = true

    transition {
      days          = "${var.jenkins_s3_move_to_ia_threshold}"
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = "${var.jenkins_s3_move_to_glacier_threshold}"
      storage_class = "GLACIER"
    }

    expiration {
      days = "${var.jenkins_s3_expiration_threshold}"
    }
  }

  versioning {
    enabled = "${var.jenkins_s3_versioning}"
  }
}
