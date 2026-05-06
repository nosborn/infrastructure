resource "github_repository" "io_osborn_mta_sts" { # tfsec:ignore:github-repositories-private
  allow_merge_commit     = false
  allow_squash_merge     = false
  allow_update_branch    = true
  archive_on_destroy     = true
  delete_branch_on_merge = true
  has_discussions        = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  name                   = "mta-sts.${hcloud_zone.io_osborn.name}"
  visibility             = "public"

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

resource "github_repository_vulnerability_alerts" "io_osborn_mta_sts" {
  repository = github_repository.io_osborn_mta_sts.name
  enabled    = true
}

resource "github_repository_webhook" "io_osborn_mta_sts_statichost" {
  repository = github_repository.io_osborn_mta_sts.name

  events = [
    "push",
  ]

  configuration {
    content_type = "json"
    url          = "https://builder.statichost.eu/mta-sts-osborn-io"
  }
}

resource "github_repository_file" "io_osborn_mta_sts_policy" {
  branch              = "main"
  commit_message      = "Update MTA-STS policy"
  file                = "public/.well-known/mta-sts.txt"
  overwrite_on_create = true
  repository          = github_repository.io_osborn_mta_sts.name

  content = <<EOT
version: STSv1
mode: enforce
%{for record in hcloud_zone_rrset.io_osborn_mx.records~}
mx: ${trimsuffix(split(" ", record.value)[1], ".")}
%{endfor~}
max_age: 86400
EOT
}

resource "hcloud_zone_rrset" "io_osborn_mta_sts_a" {
  name = "mta-sts"
  type = "A"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = "95.217.26.94"
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "io_osborn_mta_sts_aaaa" {
  name = "mta-sts"
  type = "AAAA"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = "2a01:4f9:c01f:8002::"
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_mta_sts_txt" {
  name = "_mta-sts"
  type = "TXT"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = provider::hcloud::txt_record("v=STSv1; id=${formatdate("YYYYMMDDhhmmssZ", time_static.io_osborn_mta_sts_id.rfc3339)}")
    },
  ]
}

resource "time_static" "io_osborn_mta_sts_id" {
  triggers = {
    policy_sha = github_repository_file.io_osborn_mta_sts_policy.sha
  }
}
