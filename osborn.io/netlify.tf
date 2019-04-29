resource "netlify_site" "main" {
  name          = "${replace(var.domain_name, ".", "-")}"
  custom_domain = "${var.domain_name}"

  repo {
    provider = "github"
    repo_path = "${var.github_username}/${var.domain_name}"
    repo_branch = "master"
  }
}
