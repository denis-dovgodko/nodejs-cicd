terraform {
    source = "../../modules/ec2"
}

include "root"{
    path = find_in_parent_folders()
}

inputs = {
    ec2_subnet = dependency.vpc.outputs.public_subnets[0]
    vpc_id = dependency.vpc.outputs.vpc_id
    github_repo_url = getenv("GITHUB_REPO")
    email = getenv("EMAIL")
    domain = getenv("DOMAIN")
}

dependency "vpc" {
    config_path = "./vpc"
    mock_outputs_allowed_terraform_commands = ["validate", "destroy", "init", "plan"]
    mock_outputs = {
        public_subnets = ["fake-array"]
        vpc_id = "mock"
  }
}