output "tombstone_cloudflare_api_token" {
  value       = cloudflare_api_token.tombstone.value
  description = "The value of the API Token for Tombstone."
  sensitive   = true
}

# output "wormhole_cloudflare_api_token" {
#   value       = cloudflare_api_token.wormhole.value
#   description = "The value of the API Token for Wormhole."
#   sensitive   = true
# }
