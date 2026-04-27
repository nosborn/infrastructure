resource "hcloud_storage_box" "main" {
  delete_protection = true
  location          = "fsn1"
  name              = "storage-box-1"
  password          = random_password.storagebox.result
  storage_box_type  = "bx11"

  access_settings = {
    reachable_externally = true
    ssh_enabled          = true
  }

  # snapshot_plan = {
  #   day_of_week   = 5
  #   hour          = 5
  #   max_snapshots = 10
  #   minute        = 38
  # }

  ssh_keys = [
    hcloud_ssh_key.main.public_key
  ]

  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      ssh_keys,
    ]
  }
}

resource "random_password" "storagebox" {
  length           = 64
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "^!%/()=?+#-.,;:~"
  special          = true
}

resource "hcloud_storage_box_subaccount" "hyperbackup" {
  description    = "HyperBackup"
  home_directory = "hyperbackup/"
  password       = random_password.storagebox_hyperbackup.result
  storage_box_id = hcloud_storage_box.main.id

  access_settings = {
    reachable_externally = true
    ssh_enabled          = true
  }
}

resource "random_password" "storagebox_hyperbackup" {
  length           = 64
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "^!%/()=?+#-.,;:~"
  special          = true
}
