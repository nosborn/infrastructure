resource "hcloud_ssh_key" "main" {
  name       = "20260427"
  public_key = file("~/.ssh/id_ed25519-hetzner-20260427.pub")
}
