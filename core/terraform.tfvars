project_tag = "Core"

terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
}
