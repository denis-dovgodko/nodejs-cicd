variable "ami" {
  type = string
  default = "ami-0c5ebd68eb61ff68d"
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
