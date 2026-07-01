resource "vultr_instance" "proxy_de" {
  activation_email  = false
  backups           = "disabled"
  enable_ipv6       = true
  firewall_group_id = vultr_firewall_group.main.id
  hostname          = "proxy-de.osborn.io"
  label             = "proxy-de.osborn.io"
  os_id             = data.vultr_os.debian_13.id
  plan              = "vc2-1c-1gb"
  region            = "fra" # Frankfurt

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

resource "hcloud_zone_rrset" "io_osborn_proxy_de_a" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-de"
  type = "A"

  records = [
    {
      value = vultr_instance.proxy_de.main_ip
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_de_aaaa" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-de"
  type = "AAAA"

  records = [
    {
      value = vultr_instance.proxy_de.v6_main_ip
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_de_caa" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-de"
  type = "CAA"

  records = [
    {
      value = "0 issue \";\""
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_de_mx" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-de"
  type = "MX"

  records = [
    {
      value = "0 ."
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_de_txt" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-de"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=spf1 -all")
    },
  ]
}

# resource "vultr_reverse_ipv4" "proxy_de" {
#   instance_id = vultr_instance.proxy_de.id
#   ip          = vultr_instance.proxy_de.main_ip
#   reverse     = scaleway_domain_record.proxy_de_a.fqdn
# }

# resource "vultr_reverse_ipv6" "proxy_de" {
#   instance_id = vultr_instance.proxy_de.id
#   ip          = vultr_instance.proxy_de.v6_main_ip
#   reverse     = scaleway_domain_record.proxy_de_aaaa.fqdn
# }
