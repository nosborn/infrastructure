resource "ns1_zone" "main" {
  zone = "${var.domain_name}"
}

resource "ns1_record" "ALIAS" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "ALIAS"

  answers {
    answer = "${netlify_site.main.name}.netlify.com"
  }
}

# TODO: not supported by provider
# resource "ns1_record" "CAA" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "${var.domain_name}"
#   type    = "CAA"
#   ttl     = 3600
#
#   answers {
#     answer = "0 issue \"letsencrypt.org\""
#   }
# }

resource "ns1_record" "MX" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "MX"
  ttl    = 3600

  answers {
    answer = "10 aspmx1.migadu.com."
  }

  answers {
    answer = "20 aspmx2.migadu.com."
  }
}

resource "ns1_record" "TXT" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "google-site-verification=8otHDcgVRYHCq_1KfVQQxfnZeTwN_ZLTpzWbPgq9YZQ"
  }

  answers {
    answer = "v=spf1 mx a include:spf.migadu.com ~all"
  }
}

resource "ns1_record" "bing_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "0f1893c5e1360b28dd07a5c0f317c7c3.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "verify.bing.com"
  }
}

resource "ns1_record" "dmarc_TXT" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_dmarc.${var.domain_name}"
  type   = "TXT"
  ttl    = 300 # FIXME: 3600

  answers {
    answer = "v=DMARC1; p=none; fo=1; rua=mailto:admin@${var.domain_name}"
  }
}

resource "ns1_record" "domainkey_default_TXT" {
  zone   = "${ns1_zone.main.zone}"
  domain = "default._domainkey.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDXql1/79wgfBgu3bYrS2Q/5u549MYT+iqn6zW0LrkaUXBV3FcOoJNZORGyjGjWZW3xw6TrTm9kXUHN8KChc5IxGYeaYoB/wyXrGPh0u0P1nd0Q+KnLXrmTQ+cib4GBgdOnYveFIphKOf+redZLz9W59N19UWFnuHem8t4dDRmshwIDAQAB"
  }
}

# resource "ns1_record" "imap_SRV" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "_imap._tcp.${var.domain_name}"
#   type   = "SRV"
#   ttl    = 3600
#
#   answers {
#     answer = "0 0 0 ."
#   }
# }

# resource "ns1_record" "imaps_SRV" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "_imaps._tcp.${var.domain_name}"
#   type   = "SRV"
#   ttl    = 3600
#
#   answers {
#     answer = "0 1 993 imap.migadu.com."
#   }
# }

# resource "ns1_record" "keybase_TXT" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "_keybase.${var.domain_name}"
#   type   = "TXT"
#   ttl    = 3600

#   answers {
#     answer = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
#   }
# }

# resource "ns1_record" "pop3_SRV" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "_pop3._tcp.${var.domain_name}"
#   type   = "SRV"
#   ttl    = 3600
#
#   answers {
#     answer = "0 0 0 ."
#   }
# }

# resource "ns1_record" "pop3s_SRV" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "_pop3s._tcp.${var.domain_name}"
#   type   = "SRV"
#   ttl    = 3600
#
#   answers {
#     answer = "10 1 995 imap.migadu.com."
#   }
# }

# resource "ns1_record" "submission_SRV" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "_submission._tcp.${var.domain_name}"
#   type   = "SRV"
#   ttl    = 3600
#
#   answers {
#     answer = "0 1 587 smtp.migadu.com."
#   }
# }

resource "ns1_record" "www_ALIAS" {
  zone   = "${ns1_zone.main.zone}"
  domain = "www.${var.domain_name}"
  type   = "ALIAS"
  link   = "${var.domain_name}"
}
