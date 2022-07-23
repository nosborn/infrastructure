output "domain_name" {
  value = module.website.cloudfront_domain_name
}

output "hosted_zone_id" {
  value = module.website.cloudfront_hosted_zone_id
}
