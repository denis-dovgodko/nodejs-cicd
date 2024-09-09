locals {
    aws_access = getenv("AWS_ACCESS_KEY")
    aws_secret = getenv("AWS_SECRET_KEY")
}

// remote_state {
//   disable_dependency_optimization = true
//   backend = "s3"
//   generate = {
//     path      = "backend.tf"
//     if_exists = "overwrite_terragrunt"
//   }
//   config = {
//     bucket  = "dovgodko-testtask-state"
//     encrypt = true
//     key     = "${path_relative_to_include()}/terraform.tfstate"
//     region  = "us-east-2"
//   }
// }

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    provider "aws" {
        region = "us-east-1"
        access_key = "${local.aws_access}"
        secret_key = "${local.aws_secret}"
    }
EOF
} 