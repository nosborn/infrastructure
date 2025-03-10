# resource "b2_bucket" "diskstation" {
#   bucket_name = "io-osborn-diskstation"
#   bucket_type = "allPrivate"
#
#   default_server_side_encryption {
#     mode = "none" # encrypted files not included in snapshots
#   }
#
#   lifecycle_rules {
#     file_name_prefix             = ""
#     days_from_hiding_to_deleting = 1 # "Keep only the last version"
#   }
# }

resource "b2_bucket" "tombstone" {
  bucket_name = "io-osborn-tombstone"
  bucket_type = "allPrivate"

  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }

  # lifecycle_rules {
  #   file_name_prefix             = ""
  #   days_from_hiding_to_deleting = 1 # "Keep only the last version"
  # }
}

# resource "b2_application_key" "dependabot" {
#   key_name = "Dependabot"
#
#   capabilities = [
#     "listAllBucketNames",
#     "listBuckets",
#     "listKeys",
#     "readBucketEncryption",
#     "readBucketRetentions",
#     "readBuckets",
#   ]
# }
