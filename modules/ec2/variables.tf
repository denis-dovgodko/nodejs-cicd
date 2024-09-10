variable "ami" {
  type = string
  default = "ami-025258b26b492aec6"
}

variable "type" {
  type = string
  default = "t2.micro"
}

variable "ec2_subnet" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "github_repo_url" {
  type = string
}

variable "email" {
  type = string
}

variable "domain" {
  type = string
}
