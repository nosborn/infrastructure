resource "github_repository" "io_osborn_www" { # tfsec:ignore:github-repositories-private
  allow_merge_commit     = false
  allow_squash_merge     = false
  allow_update_branch    = true
  archive_on_destroy     = true
  delete_branch_on_merge = true
  description            = "Source for [https://www.${hcloud_zone.io_osborn.name}]."
  has_discussions        = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  license_template       = "mit"
  name                   = "www.${hcloud_zone.io_osborn.name}"
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

# resource "github_branch_default" "io_osborn_www" {
#   branch     = "main"
#   repository = github_repository.io_osborn_www.name
# }

resource "github_repository_vulnerability_alerts" "io_osborn_www" {
  repository = github_repository.io_osborn_www.name
  enabled    = true
}

resource "github_repository_ruleset" "io_osborn_www_all_branches" {
  enforcement = "active"
  name        = "All Branches"
  repository  = github_repository.io_osborn_www.name
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
    required_signatures     = true
  }
}

resource "github_repository_ruleset" "io_osborn_www_default_branch" {
  enforcement = "active"
  name        = "Default Branch"
  repository  = github_repository.io_osborn_www.name
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
  }
}

resource "github_repository_webhook" "io_osborn_www_statichost" {
  repository = github_repository.io_osborn_www.name

  events = [
    "push",
  ]

  configuration {
    content_type = "json"
    url          = "https://builder.statichost.eu/www-osborn-io"
  }
}

resource "hcloud_zone_rrset" "io_osborn_a" {
  name = "@"
  type = "A"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = local.statichost_ipv4_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "io_osborn_aaaa" {
  name = "@"
  type = "AAAA"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = local.statichost_ipv6_address
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_https" {
  name = "@"
  type = "HTTPS"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = "0 www.${hcloud_zone.io_osborn.name}.",
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_www_a" {
  name = "www"
  type = "A"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = local.statichost_ipv4_address
    },
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_zone_rrset" "io_osborn_www_aaaa" {
  name = "www"
  type = "AAAA"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = local.statichost_ipv6_address
    },
  ]
}

resource "hcloud_zone_rrset" "io_osborn_www_https" {
  name = "www"
  type = "HTTPS"
  zone = hcloud_zone.io_osborn.name

  records = [
    {
      value = join(" ", [
        "1",
        ".",
        "alpn=\"h3,h2\"",
        "ipv4hint=${join(",", [for v in hcloud_zone_rrset.io_osborn_www_a.records : v.value])}",
        "ipv6hint=${join(",", [for v in hcloud_zone_rrset.io_osborn_www_aaaa.records : v.value])}",
      ])
    },
  ]
}
