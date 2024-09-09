output "ec2_ip" {
  value = "Host ip: ${aws_instance.ec2.public_ip}"
}

output "ec2_port" {
  value = "Port: 34567"
}

output "ec2_username" {
  value = "Username: ec2-user"
}