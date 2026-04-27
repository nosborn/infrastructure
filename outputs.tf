output "storage_box_server" {
  description = "FQDN of the Storage Box."
  value       = hcloud_storage_box.main.server
}

output "storage_box_subaccount_hyperbackup_password" {
  description = "The generated random string."
  value       = random_password.storagebox_hyperbackup.result
  sensitive   = true
}

output "storage_box_subaccount_hyperbackup_username" {
  description = "Name of the Storage Box Subaccount."
  value       = hcloud_storage_box_subaccount.hyperbackup.name
}
