resource "b2_bucket" "hyperbackup" {
  bucket_name = "io-osborn-hyperbackup"
  bucket_type = "allPrivate"

  default_server_side_encryption {
    mode = "none" # encrypted files not included in snapshots
  }

  lifecycle_rules {
    file_name_prefix             = ""
    days_from_hiding_to_deleting = 1 # "Keep only the last version"
  }
}

resource "b2_application_key" "hyperbackup" {
  capabilities = ["deleteFiles", "listAllBucketNames", "listBuckets", "listFiles", "readBuckets", "readFiles", "writeFiles"]
  key_name     = "HyperBackup"
  bucket_id    = b2_bucket.hyperbackup.bucket_id
}
