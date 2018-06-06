resource "statuscake_test" "HTTP" {
  website_name  = "cannoli.london"
  website_url   = "https://cannoli.london/ping.txt"
  check_rate    = 1800
  test_type     = "HTTP"
  confirmations = 2

  depends_on = [
    "aws_route53_record.A",
    "aws_route53_record.AAAA",
  ]
}
