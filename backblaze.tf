resource "b2_bucket" "diskstation" {
  bucket_name = "io-osborn-diskstation"
  bucket_type = "allPrivate"

  default_server_side_encryption {
    mode = "none" # encrypted files not included in snapshots
  }

  lifecycle_rules {
    file_name_prefix             = ""
    days_from_hiding_to_deleting = 1 # "Keep only the last version"
  }
}
