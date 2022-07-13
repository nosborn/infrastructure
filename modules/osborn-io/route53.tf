resource "aws_route53_zone" "aws" {
  name          = "aws.osborn.io"
  force_destroy = true
}

resource "aws_route53_record" "www_caa" {
  zone_id = aws_route53_zone.aws.zone_id
  name    = aws_route53_zone.aws.name
  type    = "CAA"
  ttl     = "60"
  records = formatlist("0 issuewild \"%s\"", ["amazon.com", "amazontrust.com", "awstrust.com", "amazonaws.com"])
}
