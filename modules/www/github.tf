resource "github_repository" "this" { # tfsec:ignore:github-repositories-private
  allow_merge_commit                      = false
  allow_squash_merge                      = false
  allow_update_branch                     = true
  archive_on_destroy                      = true
  delete_branch_on_merge                  = true
  description                             = "Source for [https://www.${var.domain_name}]."
  has_discussions                         = false
  has_issues                              = false
  has_projects                            = false
  has_wiki                                = false
  ignore_vulnerability_alerts_during_read = true
  license_template                        = "mit"
  name                                    = "www.${var.domain_name}"
  visibility                              = "public"
  vulnerability_alerts                    = true

  topics = [
    "static-website",
  ]

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

# resource "github_branch_default" "www" {
#   branch     = "main"
#   repository = github_repository.www.name
# }

resource "github_repository_ruleset" "all_branches" {
  enforcement = "active"
  name        = "All Branches"
  repository  = github_repository.this.name
  target      = "branch"

  conditions {
    ref_name {
      exclude = []

      include = [
        "~ALL",
      ]
    }
  }

  rules {
    required_linear_history = true
  }
}

resource "github_repository_ruleset" "default_branch" {
  enforcement = "active"
  name        = "Default Branch"
  repository  = github_repository.this.name
  target      = "branch"

  conditions {
    ref_name {
      exclude = []

      include = [
        "~DEFAULT_BRANCH",
      ]
    }
  }

  bypass_actors {
    actor_id    = 5 # admin
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }

  rules {
    creation                = true
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true

    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = true
      require_last_push_approval        = false
      required_approving_review_count   = 1
      required_review_thread_resolution = false
    }

    required_status_checks {
      do_not_enforce_on_create             = true
      strict_required_status_checks_policy = true

      required_check {
        context        = "build-and-deploy"
        integration_id = 15368 # GitHub Actions
      }
    }
  }
}

resource "github_repository_webhook" "this" {
  repository = github_repository.this.name

  events = [
    "push",
  ]

  configuration {
    content_type = "json"
    url          = "https://builder.statichost.eu/${var.statichost_site_name}"
  }
}
