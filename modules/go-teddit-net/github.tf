# # tfsec:ignore:github-repositories-private
resource "github_repository" "this" {
  name                   = "go-teddit"
  description            = "An alternative Reddit front-end focused on privacy."
  visibility             = "public"
  has_issues             = true
  has_projects           = false
  has_wiki               = false
  allow_merge_commit     = false
  allow_squash_merge     = false
  allow_rebase_merge     = true
  delete_branch_on_merge = true
  auto_init              = true
  gitignore_template     = "Go"
  license_template       = "agpl-3.0"
  archive_on_destroy     = true
  vulnerability_alerts   = true
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_branch_protection" "main" {
  repository_id           = github_repository.this.id
  pattern                 = github_branch_default.this.branch
  enforce_admins          = false # TODO: true?
  require_signed_commits  = true
  required_linear_history = true
  allows_deletions        = false
  allows_force_pushes     = false

  required_status_checks {
    strict = true

    contexts = [
      "CodeQL",
      "golangci",
    ]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
  }
}
