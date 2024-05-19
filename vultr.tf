resource "vultr_firewall_group" "main" {}

resource "vultr_firewall_rule" "domain" { # TODO: remove
  for_each = toset([
    "tcp",
    "udp",
  ])

  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "53"
  protocol          = each.key
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_firewall_rule" "domain_s" { # TODO: remove
  for_each = toset([
    "tcp",
    "udp",
  ])

  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "853"
  protocol          = each.key
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_firewall_rule" "http" {
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "80"
  protocol          = "tcp"
  subnet            = var.tombstone_ipv4_address # TODO: "0.0.0.0/0"
  subnet_size       = 32                         # TODO: 0
}

resource "vultr_firewall_rule" "https" { # TODO: remove
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "443"
  protocol          = "tcp"
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_firewall_rule" "icmp" {
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  protocol          = "icmp"
  subnet            = "0.0.0.0"
  subnet_size       = 0
}

resource "vultr_firewall_rule" "icmp_v6" {
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v6"
  protocol          = "icmp"
  subnet            = "::"
  subnet_size       = 0
}

resource "vultr_firewall_rule" "node_exporter" { # TODO: remove
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "9100"
  protocol          = "tcp"
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_firewall_rule" "openrc_exporter" { # TODO: remove
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "9816"
  protocol          = "tcp"
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_firewall_rule" "ssh" {
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "22"
  protocol          = "tcp"
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_firewall_rule" "wireguard" {
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "51820"
  protocol          = "udp"
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_firewall_rule" "wireguard_exporter" { # TODO: remove
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "9586"
  protocol          = "tcp"
  subnet            = var.tombstone_ipv4_address
  subnet_size       = 32
}

resource "vultr_ssh_key" "main" {
  name    = "id_ed25519"
  ssh_key = trimspace(file("~/.ssh/id_ed25519-vultr-20231216.pub"))
}
