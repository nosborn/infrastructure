resource "github_repository" "mta_sts" {
  name                   = "mta-sts.osborn.io"
  description            = "Source for [https://mta-sts.osborn.io]."
  allow_merge_commit     = false
  allow_squash_merge     = false
  auto_init              = true
  license_template       = "mit"
  archive_on_destroy     = true
  delete_branch_on_merge = true
  topics                 = ["mta-sts", "static-website"]
}

resource "github_branch_protection" "mta_sts_master" {
  repository_id           = github_repository.mta_sts.id
  pattern                 = "master"
  enforce_admins          = true
  require_signed_commits  = true
  required_linear_history = true
}

resource "github_repository" "www" {
  name                   = "www.osborn.io"
  description            = "Source for [https://www.osborn.io]."
  allow_merge_commit     = false
  allow_squash_merge     = false
  auto_init              = true
  license_template       = "mit"
  archive_on_destroy     = true
  delete_branch_on_merge = true
  topics                 = ["static-website"]
}

resource "github_branch_protection" "www_master" {
  repository_id           = github_repository.www.id
  pattern                 = "master"
  enforce_admins          = true
  require_signed_commits  = true
  required_linear_history = true
}
