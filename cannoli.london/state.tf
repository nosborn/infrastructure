terraform {
  backend "s3" {
    bucket = "terraform-20190402041657780700000001"
    key    = "cannoli.london/terraform.tfstate"
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
