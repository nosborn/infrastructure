#resource "vultr_instance" "starbase" {
#  activation_email  = false
#  backups           = "disabled"
#  enable_ipv6       = true
#  firewall_group_id = vultr_firewall_group.starbase.id
#  hostname          = "starbase.osborn.io"
#  label             = "starbase.osborn.io"
#  os_id             = data.vultr_os.openbsd_7_7.id
#  plan              = "vc2-1c-1gb"
#  region            = "blr" # Bangalore
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
#    users:
#      - name: fed99
#        shell: /sbin/nologin
#  EOT
#
#  lifecycle {
#    replace_triggered_by = [
#      vultr_ssh_key.main,
#    ]
#  }
#}
#
#resource "vultr_firewall_group" "starbase" {}
#
#resource "vultr_firewall_rule" "starbase_icmp_v4" {
#  firewall_group_id = vultr_firewall_group.starbase.id
#  ip_type           = "v4"
#  protocol          = "icmp"
#  subnet            = "0.0.0.0"
#  subnet_size       = 0
#}
#
#resource "vultr_firewall_rule" "starbase_icmp_v6" {
#  firewall_group_id = vultr_firewall_group.starbase.id
#  ip_type           = "v6"
#  protocol          = "icmp"
#  subnet            = "::"
#  subnet_size       = 0
#}
#
#resource "vultr_firewall_rule" "starbase_tcp_v4" {
#  for_each = toset([
#    "22",
#    "23",
#    "992",
#  ])
#
#  firewall_group_id = vultr_firewall_group.starbase.id
#  ip_type           = "v4"
#  port              = each.key
#  protocol          = "tcp"
#  subnet            = "0.0.0.0"
#  subnet_size       = 0
#}
#
#resource "vultr_firewall_rule" "starbase_tcp_v6" {
#  for_each = toset([
#    "22",
#    "23",
#    "992",
#  ])
#
#  firewall_group_id = vultr_firewall_group.starbase.id
#  ip_type           = "v6"
#  port              = each.key
#  protocol          = "tcp"
#  subnet            = "::"
#  subnet_size       = 0
#}
#
#resource "scaleway_domain_record" "starbase_a" {
#  data     = vultr_instance.starbase.main_ip
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "starbase"
#  ttl      = 60
#  type     = "A"
#}
#
#resource "scaleway_domain_record" "starbase_aaaa" {
#  data     = vultr_instance.starbase.v6_main_ip
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "starbase"
#  ttl      = 60
#  type     = "AAAA"
#}
#
#resource "scaleway_domain_record" "starbase_mx" {
#  data     = "."
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "starbase"
#  priority = 0
#  type     = "MX"
#}
#
#resource "scaleway_domain_record" "starbase_txt" {
#  data     = "v=spf1 -all"
#  dns_zone = module.osborn_io.scaleway_domain_zone_id
#  name     = "starbase"
#  type     = "TXT"
#}
#
#resource "vultr_reverse_ipv4" "starbase" {
#  instance_id = vultr_instance.starbase.id
#  ip          = vultr_instance.starbase.main_ip
#  reverse     = scaleway_domain_record.starbase_a.fqdn
#}
#
#resource "vultr_reverse_ipv6" "starbase" {
#  instance_id = vultr_instance.starbase.id
#  ip          = vultr_instance.starbase.v6_main_ip
#  reverse     = scaleway_domain_record.starbase_aaaa.fqdn
#}
