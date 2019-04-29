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
#   ttl     = 86400
#
#   answers {
#     answer = "0 issue \"letsencrypt.org\""
#   }
# }

resource "ns1_record" "MX" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "MX"
  ttl    = 300                     # FIXME: 3600

  answers {
    answer = "10 in1-smtp.messagingengine.com"
  }

  answers {
    answer = "20 in2-smtp.messagingengine.com"
  }
}

resource "ns1_record" "TXT" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "TXT"
  ttl    = 300                     # FIXME: 3600

  answers {
    answer = "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI"
  }

  answers {
    answer = "protonmail-verification=64d919e28849f07ef74e8c24881ad547805bab3e"
  }
  # https://www.fastmail.com/help/receive/domains-advanced.html#dnslist
  answers {
    answer = "v=spf1 include:spf.messagingengine.com ?all"
  }
}

resource "ns1_record" "bing_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "7f33c9bdcbfc881a50d3f5db24af19e9.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "verify.bing.com"
  }
}

resource "ns1_record" "caldav_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._caldav.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 0 0 ."
  }
}

resource "ns1_record" "caldavs_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._caldavs.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 1 443 caldav.fastmail.com"
  }
}

resource "ns1_record" "carddav_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._carddav.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 0 0 ."
  }
}

resource "ns1_record" "carddavs_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._carddavs.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 1 443 carddav.fastmail.com"
  }
}

resource "ns1_record" "domainkey_fm_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "fm${count.index + 1}._domainkey.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "fm${count.index + 1}.${var.domain_name}.dkim.fmhosted.com."
  }

  count = 3
}

resource "ns1_record" "domainkey_mesmtp_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "mesmtp._domainkey.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "mesmtp.${var.domain_name}.dkim.fmhosted.com."
  }
}

resource "ns1_record" "imap_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._imap.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 0 0 ."
  }
}

resource "ns1_record" "imaps_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._imaps.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 1 993 imap.fastmail.com"
  }
}

resource "ns1_record" "keybase_TXT" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_keybase.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
  }
}

resource "ns1_record" "nick_MX" {
  zone   = "${ns1_zone.main.zone}"
  domain = "nick.${var.domain_name}"
  type   = "MX"
  link   = "${var.domain_name}"
}

# https://www.fastmail.com/help/receive/domains-advanced.html#dnslist
resource "ns1_record" "mail_A" {
  zone   = "${ns1_zone.main.zone}"
  domain = "mail.${var.domain_name}"
  type   = "A"
  ttl    = 3600

  answers {
    answer = "66.111.4.147"
  }

  answers {
    answer = "66.111.4.148"
  }
}

resource "ns1_record" "pop3_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._pop3.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 0 0 ."
  }
}

resource "ns1_record" "pop3s_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._pop3s.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 1 995 pop.fastmail.com"
  }
}

resource "ns1_record" "submission_tcp_SRV" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_tcp._submission.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 1 587 smtp.fastmail.com"
  }
}

resource "ns1_record" "www_ALIAS" {
  zone   = "${ns1_zone.main.zone}"
  domain = "www.${var.domain_name}"
  type   = "ALIAS"
  link   = "${var.domain_name}"
}
