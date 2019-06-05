resource "ns1_zone" "main" {
  zone = var.domain_name
}

resource "ns1_record" "A" {
  zone   = ns1_zone.main.zone
  domain = var.domain_name
  type   = "A"

  answers {
    answer = "185.199.108.153"
  }

  answers {
    answer = "185.199.109.153"
  }

  answers {
    answer = "185.199.110.153"
  }

  answers {
    answer = "185.199.111.153"
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
  zone   = ns1_zone.main.zone
  domain = var.domain_name
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
  zone   = ns1_zone.main.zone
  domain = var.domain_name
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "google-site-verification=7sk8qJzYVrVYBq6gk135CfGRaLAa2fH5hWhEVEBNgqI"
  }

  # answers {
  #   answer = "protonmail-verification=64d919e28849f07ef74e8c24881ad547805bab3e"
  # }

  answers {
    answer = "v=spf1 mx a include:spf.migadu.com ~all"
  }
}

resource "ns1_record" "bing_CNAME" {
  zone   = ns1_zone.main.zone
  domain = "7f33c9bdcbfc881a50d3f5db24af19e9.${var.domain_name}"
  type   = "CNAME"
  ttl    = 3600

  answers {
    answer = "verify.bing.com"
  }
}

resource "ns1_record" "dmarc_TXT" {
  zone   = ns1_zone.main.zone
  domain = "_dmarc.${var.domain_name}"
  type   = "TXT"
  ttl    = 300 # FIXME: 3600

  answers {
    answer = "v=DMARC1; p=none; fo=1; rua=mailto:admin@${var.domain_name}"
  }
}

resource "ns1_record" "domainkey_default_TXT" {
  zone   = ns1_zone.main.zone
  domain = "default._domainkey.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDFByJNY3YVaG7bw3C2+qjr1j0isGbHUZrJluhQWvl80v+szk7L7kWOmoKQFpm/ky9MZoIdMd3MMeVJuVhzP69W9g/qiQItb8An/vOBuxwBbSzZpE3VmXsHw5bgssn9BQKWvMmJGq+qTUE4kl9vV4HlfVw/TVT2sCuM+I9paLihOQIDAQAB"
  }
}

resource "ns1_record" "imap_SRV" {
  zone   = ns1_zone.main.zone
  domain = "_imap._tcp.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 0 0 ."
  }
}

resource "ns1_record" "imaps_SRV" {
  zone   = ns1_zone.main.zone
  domain = "_imaps._tcp.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 1 993 imap.migadu.com."
  }
}

resource "ns1_record" "keybase_TXT" {
  zone   = ns1_zone.main.zone
  domain = "_keybase.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "keybase-site-verification=H4Tg4vG9nr9YFoI-3bZoq6TTFU2s3ZKwRxA8I9GMBg4"
  }
}

resource "ns1_record" "nick_MX" {
  zone   = ns1_zone.main.zone
  domain = "nick.${var.domain_name}"
  type   = "MX"
  link   = var.domain_name
}

resource "ns1_record" "nick_TXT" {
  zone   = ns1_zone.main.zone
  domain = "nick.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "v=spf1 mx a include:spf.migadu.com ~all"
  }
}

resource "ns1_record" "nick_domainkey_default_TXT" {
  zone   = ns1_zone.main.zone
  domain = "default._domainkey.nick.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCsH9zwOVNT9NobOAvbZnB3N2rTaywltT2rxI4N7+SGEmDgbOmP4LRf0qIUcUskohrEAo76b/1Ogkw5Oq0eep5+vKi8AwJSW8uoykvWEDrswoKECvxriG0sByuFYi53RkYei1hDkL1tjnIJCjRUPAN2MyzeLzUcnoR0v3ha5xGINQIDAQAB"
  }
}

resource "ns1_record" "pop3_SRV" {
  zone   = ns1_zone.main.zone
  domain = "_pop3._tcp.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 0 0 ."
  }
}

resource "ns1_record" "pop3s_SRV" {
  zone   = ns1_zone.main.zone
  domain = "_pop3s._tcp.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "10 1 995 imap.migadu.com."
  }
}

resource "ns1_record" "submission_SRV" {
  zone   = ns1_zone.main.zone
  domain = "_submission._tcp.${var.domain_name}"
  type   = "SRV"
  ttl    = 3600

  answers {
    answer = "0 1 587 smtp.migadu.com."
  }
}

resource "ns1_record" "tombstone_MX" {
  zone   = ns1_zone.main.zone
  domain = "tombstone.${var.domain_name}"
  type   = "MX"
  link   = var.domain_name
}

resource "ns1_record" "tombstone_TXT" {
  zone   = ns1_zone.main.zone
  domain = "tombstone.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "v=spf1 mx a include:spf.migadu.com ~all"
  }
}

resource "ns1_record" "tombstone_domainkey_default_TXT" {
  zone   = ns1_zone.main.zone
  domain = "default._domainkey.tombstone.${var.domain_name}"
  type   = "TXT"
  ttl    = 3600

  answers {
    answer = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwEQBLDX8DjNiVHYkc+znhgAeZx3ffIsm66y+i7y/Ocf+kWZXruClDJeijgaZ4V37Y3CTVeORwu2vSq1hju1K9/cToXvtMDtg7ItNcTpHB+WeyMt/QOVCiqPBibIAFbTIHj5S/SjTPu+2CHkvpBXV7vhdzbo1wG1SGkqA7UfGm/wIDAQAB"
  }
}

resource "ns1_record" "www_A" {
  zone   = ns1_zone.main.zone
  domain = "www.${var.domain_name}"
  type   = "A"

  answers {
    answer = "185.199.108.153"
  }

  answers {
    answer = "185.199.109.153"
  }

  answers {
    answer = "185.199.110.153"
  }

  answers {
    answer = "185.199.111.153"
  }
}

