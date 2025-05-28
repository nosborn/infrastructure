resource "b2_bucket" "cloudsync" {
  bucket_name = "io-osborn-cloudsync"
  bucket_type = "allPrivate"

  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }

  lifecycle_rules {
    file_name_prefix             = ""
    days_from_hiding_to_deleting = 30
  }
}

resource "b2_application_key" "cloudsync" {
  bucket_id = b2_bucket.cloudsync.id
  key_name  = "CloudSync"

  capabilities = [
    "deleteFiles",
    "listBuckets",
    "listFiles",
    "readBuckets",
    "readFiles",
    "writeFiles",
  ]
}

resource "b2_bucket" "diskstation" {
  bucket_name = "io-osborn-diskstation"
  bucket_type = "allPrivate"

  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }

  lifecycle_rules {
    file_name_prefix             = ""
    days_from_hiding_to_deleting = 1 # "Keep only the last version"
  }
}

resource "b2_application_key" "hyperbackup" {
  bucket_id = b2_bucket.diskstation.id
  key_name  = "HyperBackup"

  capabilities = [
    "deleteFiles",
    "listBuckets",
    "listFiles",
    "readBuckets",
    "readFiles",
    "writeFiles",
  ]
}
