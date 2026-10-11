resource "vultr_instance" "proxy_nl" {
  activation_email  = false
  backups           = "disabled"
  enable_ipv6       = true
  firewall_group_id = vultr_firewall_group.main.id
  hostname          = "proxy-nl.osborn.io"
  label             = "proxy-nl.osborn.io"
  os_id             = data.vultr_os.debian_13.id
  plan              = "vc2-1c-1gb"
  region            = "ams" # Amsterdam

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

resource "hcloud_zone_rrset" "io_osborn_proxy_nl_a" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-nl"
  type = "A"

  records = [
    {
      value = vultr_instance.proxy_nl.main_ip
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_nl_aaaa" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-nl"
  type = "AAAA"

  records = [
    {
      value = vultr_instance.proxy_nl.v6_main_ip
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_nl_caa" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-nl"
  type = "CAA"

  records = [
    {
      value = "0 issue \";\""
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_nl_mx" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-nl"
  type = "MX"

  records = [
    {
      value = "0 ."
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_proxy_nl_txt" {
  zone = hcloud_zone.io_osborn.name
  name = "proxy-nl"
  type = "TXT"

  records = [
    {
      value = provider::hcloud::txt_record("v=spf1 -all")
    },
  ]
}

resource "vultr_reverse_ipv4" "proxy_nl" {
  instance_id = vultr_instance.proxy_nl.id
  ip          = vultr_instance.proxy_nl.main_ip
  reverse     = "${hcloud_zone_rrset.io_osborn_proxy_nl_a.name}.${hcloud_zone.io_osborn.name}"
}

resource "vultr_reverse_ipv6" "proxy_nl" {
  instance_id = vultr_instance.proxy_nl.id
  ip          = vultr_instance.proxy_nl.v6_main_ip
  reverse     = "${hcloud_zone_rrset.io_osborn_proxy_nl_aaaa.name}.${hcloud_zone.io_osborn.name}"
}
