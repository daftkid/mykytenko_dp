#--------------------------------------------------------------
# An S3 bucket to hold files from webapp
#--------------------------------------------------------------
resource "aws_s3_bucket" "webapp_backup_bucket" {
  bucket = "webapp-backup-${var.webapp_environment}-${var.webapp_region}"
  acl    = "private"

  tags {
    Name         = "webapp-backup-${var.webapp_environment}-${var.webapp_region}"
    Purpose      = "Host files from webapp instance"
    created_with = "Terraform"
  }

  lifecycle_rule {
    id      = "all"
    prefix  = "/"
    enabled = true

    transition {
      days          = "${var.webapp_s3_move_to_ia_threshold}"
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = "${var.webapp_s3_move_to_glacier_threshold}"
      storage_class = "GLACIER"
    }

    expiration {
      days = "${var.webapp_s3_expiration_threshold}"
    }
  }

  versioning {
    enabled = false
  }
}
