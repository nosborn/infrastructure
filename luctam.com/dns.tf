resource "ns1_zone" "main" {
  zone = "${var.domain_name}"
}

resource "ns1_record" "A" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "A"
  ttl    = 3600

  answers {
    answer = "184.168.221.62"
  }
}

## TODO: not supported by provider
## resource "ns1_record" "CAA" {
##   zone   = "${ns1_zone.main.zone}"
##   domain = "${var.domain_name}"
##   type    = "CAA"
##   ttl     = 3600
##
##   answers {
##     answer = "0 issue \"letsencrypt.org\""
##   }
## }

resource "ns1_record" "MX" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "MX"
  ttl    = 3600

  answers {
    answer = "0 smtp.secureserver.net" # TODO: "10 aspmx1.migadu.com"
  }

  answers {
    answer = "10 mailstore1.secureserver.net" # TODO: "20 aspmx2.migadu.com"
  }
}

# TODO:
#resource "ns1_record" "TXT" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "${var.domain_name}"
#  type   = "TXT"
#  ttl    = 3600
#
#  # answers {
#  #   answer = "google-site-verification=8otHDcgVRYHCq_1KfVQQxfnZeTwN_ZLTpzWbPgq9YZQ"
#  # }
#
#  answers {
#    answer = "v=spf1 a mx include:spf.migadu.com ~all"
#  }
#}

# TODO:
#resource "ns1_record" "dmarc_TXT" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "_dmarc.${var.domain_name}"
#  type   = "TXT"
#  ttl    = 3600
#
#  answers {
#    answer = "v=DMARC1; p=none; fo=1; rua=mailto:admin@${var.domain_name}"
#  }
#}

resource "ns1_record" "domainconnect_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_domainconnect.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "_domainconnect.gd.domaincontrol.com"
  }
}

# TODO:
#resource "ns1_record" "domainkey_default_TXT" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "default._domainkey.${var.domain_name}"
#  type   = "TXT"
#  ttl    = 3600
#
#  answers {
#    answer = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC/FYy4ulBhN7tpLHk4eyCSWcercYojkGrNUmd22asAgLoetJ7qRN0EhBxk15YDqtKS8gM1brOumCVb8/8niM2WFa0d7jIuL297F4LXfsC3FTD1fSUWIkQO36j8/9yNK1ptrHQCfFYelUlJCh1SUoF5xPdtJtpqo8OuWw9K4gSejQIDAQAB"
#  }
#}

resource "ns1_record" "e_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "e.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "email.secureserver.net"
  }
}

resource "ns1_record" "email_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "email.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "email.secureserver.net"
  }
}

resource "ns1_record" "ftp_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "ftp.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "${var.domain_name}"
  }
}

resource "ns1_record" "imap_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "imap.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "imap.secureserver.net"
  }
}

#resource "ns1_record" "imap_SRV" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "_imap._tcp.${var.domain_name}"
#  type   = "SRV"
#  ttl    = 3600
#
#  answers {
#    answer = "0 0 0 ."
#  }
#}

#resource "ns1_record" "imaps_SRV" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "_imaps._tcp.${var.domain_name}"
#  type   = "SRV"
#  ttl    = 3600
#
#  answers {
#    answer = "0 1 993 imap.migadu.com"
#  }
#}

resource "ns1_record" "mail_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "mail.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "pop.secureserver.net" # TODO: "webmail.migadu.com"
  }
}

resource "ns1_record" "mobilemail_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "mobilemail.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "mobilemail-v01.prod.mesa1.secureserver.net"
  }
}

resource "ns1_record" "pda_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "pda.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "mobilemail-v01.prod.mesa1.secureserver.net"
  }
}

resource "ns1_record" "pop_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "pop.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "pop.secureserver.net" # TODO: "webmail.migadu.com"
  }
}

#resource "ns1_record" "pop3_SRV" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "_pop3._tcp.${var.domain_name}"
#  type   = "SRV"
#  ttl    = 3600
#
#  answers {
#    answer = "0 0 0 ."
#  }
#}

#resource "ns1_record" "pop3s_SRV" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "_pop3s._tcp.${var.domain_name}"
#  type   = "SRV"
#  ttl    = 3600
#
#  answers {
#    answer = "10 1 995 imap.migadu.com"
#  }
#}

resource "ns1_record" "smtp_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "smtp.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "smtp.secureserver.net"
  }
}

#resource "ns1_record" "submission_SRV" {
#  zone   = "${ns1_zone.main.zone}"
#  domain = "_submission._tcp.${var.domain_name}"
#  type   = "SRV"
#  ttl    = 3600
#
#  answers {
#    answer = "0 1 587 smtp.migadu.com"
#  }
#}

resource "ns1_record" "webmail_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "webmail.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "webmail.secureserver.net"
  }
}

resource "ns1_record" "www_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "www.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "${var.domain_name}"
  }
}
