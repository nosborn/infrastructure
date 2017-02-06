output "account_alias" {
  value = "${data.aws_iam_account_alias.current.account_alias}"
}

output "allowed_account_id" {
  value = "${var.allowed_account_id}"
}

output "delegation_set_id" {
  value = "${aws_route53_delegation_set.core.id}"
}

output "name_servers" {
  value = "${aws_route53_delegation_set.core.name_servers}"
}
