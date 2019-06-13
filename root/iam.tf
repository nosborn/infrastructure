resource "aws_iam_account_alias" "main" {
  account_alias = var.account_alias
}

resource "aws_iam_account_password_policy" "main" {
  allow_users_to_change_password = true
  minimum_password_length        = 12
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
}
