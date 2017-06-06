#------------------------------------------------------------------------------
# File: statefile.tf
# Description: Configure remote statefile/backend
#------------------------------------------------------------------------------
terraform {
  backend "s3" {
    bucket  = "mykytenko-dp-statefile"
    key     = "tfstate/mykytenko-dp.tfstate"
    region  = "us-east-1"
    profile = "${var.global_work_profile}"
  }
}
