module "content_bucket" {
  source = "../modules/content-bucket"

  domain_name = var.domain_name

  tags = {
    Project = var.domain_name
  }
}

module "redirect_bucket" {
  source = "../modules/redirect-bucket"

  domain_name = var.domain_name

  tags = {
    Project = var.domain_name
  }
}
