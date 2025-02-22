module "mta_sts" {
  source = "../mta-sts"

  container_namespace_id          = scaleway_container_namespace.this.id
  container_registry_endpoint     = scaleway_registry_namespace.this.endpoint
  dependabot_scaleway_api_key     = var.dependabot_scaleway_api_key
  domain_name                     = data.scaleway_domain_zone.this.domain
  github_actions_scaleway_api_key = var.github_actions_scaleway_api_key
  id                              = "20220916115504Z"
  mx_fqdns                        = [for v in scaleway_domain_record.mx : trimsuffix(v.data, ".")]

  depends_on = [
    scaleway_domain_record.caa_iodef,
    scaleway_domain_record.caa_issue,
  ]
}
