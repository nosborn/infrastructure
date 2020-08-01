module "content_bucket" {
  source = "../modules/content_bucket"

  providers = {
    aws = aws.eu-west-2
  }

  domain_name = var.domain_name

  tags = {
    Project = var.domain_name
  }
}

module "redirect_bucket" {
  source = "../modules/redirect_bucket"

  providers = {
    aws = aws.eu-west-2
  }

  domain_name = var.domain_name

  tags = {
    Project = var.domain_name
  }
}
