resource "vultr_instance" "proxy_in" {
  activation_email  = false
  backups           = "disabled"
  enable_ipv6       = true
  firewall_group_id = vultr_firewall_group.main.id
  hostname          = "proxy-in.osborn.io"
  label             = "proxy-in.osborn.io"
  os_id             = 2136 # Debian 12 x64 (bookworm)
  plan              = "vc2-1c-1gb"
  region            = "bom"

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

resource "scaleway_domain_record" "proxy_in_a" {
  data     = vultr_instance.proxy_in.main_ip
  dns_zone = module.osborn_io.scaleway_domain_zone_id
  name     = "proxy-in"
  type     = "A"
}

resource "scaleway_domain_record" "proxy_in_aaaa" {
  data     = vultr_instance.proxy_in.v6_main_ip
  dns_zone = module.osborn_io.scaleway_domain_zone_id
  name     = "proxy-in"
  type     = "AAAA"
}

resource "scaleway_domain_record" "proxy_in_mx" {
  data     = "."
  dns_zone = module.osborn_io.scaleway_domain_zone_id
  name     = "proxy-in"
  priority = 0
  type     = "MX"
}

resource "scaleway_domain_record" "proxy_in_txt" {
  data     = "v=spf1 -all"
  dns_zone = module.osborn_io.scaleway_domain_zone_id
  name     = "proxy-in"
  type     = "TXT"
}

resource "vultr_reverse_ipv4" "proxy_in" {
  instance_id = vultr_instance.proxy_in.id
  ip          = vultr_instance.proxy_in.main_ip
  reverse     = scaleway_domain_record.proxy_in_a.fqdn
}

resource "vultr_reverse_ipv6" "proxy_in" {
  instance_id = vultr_instance.proxy_in.id
  ip          = vultr_instance.proxy_in.v6_main_ip
  reverse     = scaleway_domain_record.proxy_in_aaaa.fqdn
}
