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
  key_name = "CloudSync"

  bucket_ids = [
    b2_bucket.cloudsync.id,
  ]

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
  key_name = "HyperBackup"

  bucket_ids = [
    b2_bucket.diskstation.id,
  ]

  capabilities = [
    "deleteFiles",
    "listBuckets",
    "listFiles",
    "readBuckets",
    "readFiles",
    "writeFiles",
  ]
}
