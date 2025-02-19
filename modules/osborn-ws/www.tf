module "www" {
  source = "../www"

  container_namespace_id          = scaleway_container_namespace.this.id
  container_registry_endpoint     = scaleway_registry_namespace.this.endpoint
  dependabot_scaleway_api_key     = var.dependabot_scaleway_api_key
  domain_name                     = "osborn.ws"
  github_actions_scaleway_api_key = var.github_actions_scaleway_api_key
  scaleway_dns_zone               = "osborn.ws"

  depends_on = [
    scaleway_domain_record.caa_iodef,
    scaleway_domain_record.caa_issue,
  ]
}
