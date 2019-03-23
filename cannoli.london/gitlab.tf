resource "gitlab_project" "main" {
  name                                  = "cannoli.london"
  description                           = "London Cannoli Map"
  default_branch                        = "master"
  issues_enabled                        = true
  merge_requests_enabled                = true
  wiki_enabled                          = false
  snippets_enabled                      = false
  visibility_level                      = "public"
  only_allow_merge_if_pipeline_succeeds = true
}
