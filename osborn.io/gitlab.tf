resource "gitlab_project" "main" {
  name                   = "osborn.io"
  description            = "Source for [https://osborn.io]."
  default_branch         = "master"
  issues_enabled         = true
  merge_requests_enabled = false
  wiki_enabled           = false
  snippets_enabled       = false
  visibility_level       = "public"
}
