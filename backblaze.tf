resource "b2_bucket" "diskstation" { # DEPRECATED
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

resource "b2_bucket" "hyperbackup" { # DEPRECATED
  bucket_name = "io-osborn-hyperbackup"
  bucket_type = "allPrivate"

  lifecycle_rules {
    file_name_prefix             = ""
    days_from_hiding_to_deleting = 1 # "Keep only the last version"
  }
}

resource "b2_application_key" "cloudsync" { # DEPRECATED
  key_name = "CloudSync"

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

resource "b2_application_key" "hyperbackup" { # DEPRECATED
  key_name = "HyperBackup"

  bucket_ids = [
    b2_bucket.hyperbackup.id,
  ]

  capabilities = [
    "deleteFiles",
    "listAllBucketNames",
    "listBuckets",
    "listFiles",
    "readBuckets",
    "readFiles",
    "writeFiles",
  ]
}
