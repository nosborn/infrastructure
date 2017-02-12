# TODO:
#resource "statuscake_test" "DNS" {
#  website_name  = "cannoli.london"
#  website_url   = "cannoli.london"
#  test_type     = "DNS"
#  confirmations = 2
#}

resource "statuscake_test" "HTTP" {
  website_name  = "cannoli.london"
  website_url   = "https://cannoli.london/ping.txt"
  test_type     = "HTTP"
  confirmations = 2

  depends_on = [
    "aws_route53_record.A",
    "aws_route53_record.AAAA"
  ]
}
