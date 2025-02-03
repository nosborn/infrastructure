resource "aws_kms_key" "main" {
  deletion_window_in_days = 7

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_alias" "main" {
  name          = "alias/main"
  target_key_id = aws_kms_key.main.key_id
}
