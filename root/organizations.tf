resource "aws_organizations_organization" "main" {
  feature_set = "ALL"
}

# resource "aws_organizations_account" "cannoli" {
#   name                       = "Cannoli"
#   email                      = "aws-cannoli@${var.organization_email_domain}"
#   iam_user_access_to_billing = "DENY"
# }

# resource "aws_organizations_account" "osborn_io" {
#   name                       = "Osborn.IO"
#   email                      = "aws-osborn-io@${var.organization_email_domain}"
#   iam_user_access_to_billing = "DENY"
# }

# resource "aws_organizations_account" "osborn_ws" {
#   name                       = "Osborn.WS"
#   email                      = "aws-osborn-ws@${var.organization_email_domain}"
#   iam_user_access_to_billing = "DENY"
# }
