terraform {
  backend "s3" {
    bucket = "terraform-20190402041657780700000001"
    key    = "osborn.io/terraform.tstate"
    region = "ap-southeast-1"
  }
}

# data "terraform_remote_state" "root" {
#   backend = "local"
#
#   config = {
#     path = "${path.module}/../root/terraform.tfstate"
#   }
# }

