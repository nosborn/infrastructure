terraform {
  backend "s3" {
    bucket = "terraform-20190402041657780700000001"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}
