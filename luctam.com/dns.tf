resource "ns1_zone" "main" {
  zone = "${var.domain_name}"
}

# TODO: not supported by provider
# resource "ns1_record" "CAA" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "${var.domain_name}"
#   type    = "CAA"
#   ttl     = 3600
#
#   answers {
#     answer = "0 issue \";\""
#   }
# }

resource "ns1_record" "MX" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "MX"
  ttl    = 3600

  answers {
    answer = "10 aspmx1.migadu.com"
  }

  answers {
    answer = "20 aspmx2.migadu.com"
  }
}

resource "ns1_record" "TXT" {
  zone   = "${ns1_zone.main.zone}"
  domain = "${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "v=spf1 a mx include:spf.migadu.com ~all"
  }
}

resource "ns1_record" "dmarc_TXT" {
  zone   = "${ns1_zone.main.zone}"
  domain = "_dmarc.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

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
    answer = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC/FYy4ulBhN7tpLHk4eyCSWcercYojkGrNUmd22asAgLoetJ7qRN0EhBxk15YDqtKS8gM1brOumCVb8/8niM2WFa0d7jIuL297F4LXfsC3FTD1fSUWIkQO36j8/9yNK1ptrHQCfFYelUlJCh1SUoF5xPdtJtpqo8OuWw9K4gSejQIDAQAB"
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
#     answer = "0 1 993 imap.migadu.com"
#   }
# }

resource "ns1_record" "mail_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "mail.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "webmail.migadu.com"
  }
}

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
#     answer = "10 1 995 imap.migadu.com"
#   }
# }

# resource "ns1_record" "submission_SRV" {
#   zone   = "${ns1_zone.main.zone}"
#   domain = "_submission._tcp.${var.domain_name}"
#   type   = "SRV"
#   ttl    = 3600
#
#   answers {
#     answer = "0 1 587 smtp.migadu.com"
#   }
# }

resource "ns1_record" "webmail_CNAME" {
  zone   = "${ns1_zone.main.zone}"
  domain = "webmail.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "webmail.migadu.com"
  }
}
