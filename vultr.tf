resource "vultr_firewall_group" "main" {}

resource "vultr_firewall_rule" "https_v4" {
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v4"
  port              = "443"
  protocol          = "tcp"
  subnet            = split("/", var.vultr_firewall_allow_v4)[0]
  subnet_size       = split("/", var.vultr_firewall_allow_v4)[1]
}

resource "vultr_firewall_rule" "icmp_v4" {
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

resource "vultr_firewall_rule" "ssh_v6" {
  firewall_group_id = vultr_firewall_group.main.id
  ip_type           = "v6"
  port              = "22"
  protocol          = "tcp"
  subnet            = split("/", var.vultr_firewall_allow_v6)[0]
  subnet_size       = split("/", var.vultr_firewall_allow_v6)[1]
}

resource "vultr_ssh_key" "main" {
  name    = "20240617"
  ssh_key = trimspace(file("~/.ssh/id_ed25519-vultr-20240617.pub"))
}
