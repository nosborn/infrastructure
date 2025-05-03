resource "github_repository" "this" { # tfsec:ignore:github-repositories-private
  allow_merge_commit                      = false
  allow_squash_merge                      = false
  allow_update_branch                     = true
  archive_on_destroy                      = true
  delete_branch_on_merge                  = true
  has_discussions                         = false
  has_issues                              = false
  has_projects                            = false
  has_wiki                                = false
  ignore_vulnerability_alerts_during_read = true
  name                                    = "mta-sts.${var.domain_name}"
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

resource "github_repository_file" "policy" {
  branch              = "main"
  commit_message      = "Update MTA-STS policy"
  file                = "public/.well-known/mta-sts.txt"
  overwrite_on_create = true
  repository          = github_repository.this.name

  content = <<EOT
version: STSv1
mode: enforce
%{for fqdn in var.mx_fqdns~}
mx: ${fqdn}
%{endfor~}
max_age: 86400
EOT
}
