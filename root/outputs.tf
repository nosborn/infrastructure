# output "cannoli_account_arn" {
#   value = "${aws_organizations_account.cannoli.id}"
# }

output "cloudtrail_bucket_id" {
  value = "${aws_s3_bucket.cloudtrail.id}"
}

# output "osborn_io_account_arn" {
#   value = "${aws_organizations_account.osborn_io.id}"
# }

# output "osborn_ws_account_arn" {
#   value = "${aws_organizations_account.osborn_ws.id}"
# }

output "terraform_bucket_id" {
  value = "${aws_s3_bucket.terraform.id}"
}
