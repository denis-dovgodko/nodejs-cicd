terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.8.1"
}

include "root"{
    path = find_in_parent_folders()
}

inputs = {
  name = "nodejs"
  cidr = "192.168.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["192.168.21.0/24", "192.168.22.0/24"]
  enable_nat_gateway = true
  one_nat_gateway_per_az = true
}