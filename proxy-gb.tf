resource "vultr_instance" "proxy_gb" {
  activation_email  = false
  backups           = "disabled"
  enable_ipv6       = true
  firewall_group_id = vultr_firewall_group.main.id
  hostname          = "proxy-gb.osborn.io"
  os_id             = 2076 # Alpine Linux x64
  plan              = "vc2-1c-1gb"
  region            = "lhr"

  ssh_key_ids = [
    vultr_ssh_key.main.id,
  ]

  user_data = <<-EOT
    #cloud-config
    disable_root: false
    ssh_genkeytypes:
      - ed25519
    ssh_pwauth: false
    package_update: true
    package_upgrade: true
    package_reboot_if_required: true
  EOT

  lifecycle {
    replace_triggered_by = [
      vultr_ssh_key.main,
    ]
  }
}

resource "aws_route53_record" "proxy_gb_a" {
  name    = vultr_instance.proxy_gb.hostname
  ttl     = 60
  type    = "A"
  zone_id = module.osborn_io.route53_zone_id

  records = [
    vultr_instance.proxy_gb.main_ip,
  ]
}

resource "aws_route53_record" "proxy_gb_aaaa" {
  name    = vultr_instance.proxy_gb.hostname
  ttl     = 60
  type    = "AAAA"
  zone_id = module.osborn_io.route53_zone_id

  records = [
    vultr_instance.proxy_gb.v6_main_ip,
  ]
}

resource "aws_route53_record" "proxy_gb_caa" {
  name    = vultr_instance.proxy_gb.hostname
  ttl     = 60
  type    = "CAA"
  zone_id = module.osborn_io.route53_zone_id

  records = [
    "0 issue \"letsencrypt.org;validationmethods=http-01\"",
    "0 issuewild \";\"",
  ]
}

resource "aws_route53_record" "proxy_gb_mx" {
  name    = vultr_instance.proxy_gb.hostname
  ttl     = 3600
  type    = "MX"
  zone_id = module.osborn_io.route53_zone_id

  records = [
    "0 .",
  ]
}

resource "aws_route53_record" "proxy_gb_txt" {
  name    = vultr_instance.proxy_gb.hostname
  ttl     = 3600
  type    = "TXT"
  zone_id = module.osborn_io.route53_zone_id

  records = [
    "v=spf1 -all",
  ]
}
