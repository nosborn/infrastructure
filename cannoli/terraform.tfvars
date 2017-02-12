domain_name = "cannoli.london"
project_tag = "Cannoli"

terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
  dependencies = {
    paths = ["../core"]
  }
}
