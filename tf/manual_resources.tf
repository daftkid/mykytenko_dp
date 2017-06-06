#-------------------------------------------------------------
# All the resources that we have created manually in our account
#-------------------------------------------------------------
# The certificate that was created earlier
data "aws_acm_certificate" "main_cert" {
  domain   = "*.mykytenko-dp.com"
  statuses = ["ISSUED"]
}

# The Route53 hosted zone that was created manually
data "aws_route53_zone" "main_zone" {
  name         = "mykytenko-dp.com"
  private_zone = false
}