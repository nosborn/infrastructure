#output "certbot_access_key_id" {
#  value = "${aws_iam_access_key.certbot.id}"
#}

#output "certbot_secret_access_key" {
#  value = "${aws_iam_access_key.certbot.secret}"
#}

output "dyndns_access_key_id" {
  value = "${aws_iam_access_key.dyndns.id}"
}

output "dyndns_secret_access_key" {
  value = "${aws_iam_access_key.dyndns.secret}"
}

output "name_servers" {
  value = "${aws_route53_zone.main.name_servers}"
}
