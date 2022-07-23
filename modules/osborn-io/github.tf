# tfsec:ignore:github-repositories-private
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
  vulnerability_alerts   = true
}

resource "github_branch_protection" "www_main" {
  repository_id           = github_repository.www.id
  pattern                 = "main"
  enforce_admins          = true
  require_signed_commits  = true
  required_linear_history = true
}
