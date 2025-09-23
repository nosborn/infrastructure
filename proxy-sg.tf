#resource "vultr_instance" "proxy_sg" {
#  activation_email  = false
#  backups           = "disabled"
#  enable_ipv6       = true
#  firewall_group_id = vultr_firewall_group.main.id
#  hostname          = "proxy-sg.osborn.io"
#  label             = "proxy-sg.osborn.io"
#  os_id             = data.vultr_os.debian_13.id
#  plan              = "vc2-1c-1gb"
#  region            = "sgp" # Singapore
#
#  ssh_key_ids = [
#    vultr_ssh_key.main.id,
#  ]
#
#  user_data = <<-EOT
#    #cloud-config
#    disable_root: false
#    ssh_genkeytypes:
#      - ed25519
#    ssh_pwauth: false
#    package_update: true
#    package_upgrade: true
#    package_reboot_if_required: true
#  EOT
#
#  lifecycle {
#    replace_triggered_by = [
#      vultr_ssh_key.main,
#    ]
#  }
#}
#
#resource "scaleway_domain_record" "proxy_sg_a" {
#  data     = vultr_instance.proxy_sg.main_ip
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "proxy-sg"
#  ttl      = 60
#  type     = "A"
#}
#
#resource "scaleway_domain_record" "proxy_sg_aaaa" {
#  data     = vultr_instance.proxy_sg.v6_main_ip
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "proxy-sg"
#  ttl      = 60
#  type     = "AAAA"
#}
#
#resource "scaleway_domain_record" "proxy_sg_mx" {
#  data     = "."
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "proxy-sg"
#  priority = 0
#  type     = "MX"
#}
#
#resource "scaleway_domain_record" "proxy_sg_txt" {
#  data     = "v=spf1 -all"
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "proxy-sg"
#  type     = "TXT"
#}
#
#resource "vultr_reverse_ipv4" "proxy_sg" {
#  instance_id = vultr_instance.proxy_sg.id
#  ip          = vultr_instance.proxy_sg.main_ip
#  reverse     = scaleway_domain_record.proxy_sg_a.fqdn
#}
#
#resource "vultr_reverse_ipv6" "proxy_sg" {
#  instance_id = vultr_instance.proxy_sg.id
#  ip          = vultr_instance.proxy_sg.v6_main_ip
#  reverse     = scaleway_domain_record.proxy_sg_aaaa.fqdn
#}
