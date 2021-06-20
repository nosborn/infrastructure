# resource "b2_bucket" "diskstation" {
#   bucket_name = "io-osborn-hyperbackup"
#   bucket_type = "allPrivate"
# }

# resource "b2_application_key" "hyperbackup" {
#   capabilities = ["deleteFiles", "listBuckets", "listFiles", "readFiles", "writeFiles"]
#   key_name     = "BackBlaze"
#   bucket_id    = b2_bucket.diskstation.id
# }
