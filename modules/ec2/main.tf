resource "tls_private_key" "tls_keys" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "public_key_to_ec2" {
  key_name   = "public_key_to_bastion"
  public_key = tls_private_key.tls_keys.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.tls_keys.private_key_pem
  filename = "../../../../../ec2-key.pem"
}

resource "aws_security_group" "ec2_sg" {
  name   = "ec2_sg"
  vpc_id = var.vpc_id
  ingress {
    description     = "Allow ssh"
    protocol        = "tcp"
    to_port         = 34567
    from_port = 34567
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    description     = "Allow Sonarqube"
    protocol        = "tcp"
    from_port       = 9000
    to_port         = 9000
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    description     = "Allow HTTP"
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    description     = "Allow HTTPS"
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    description     = "Allow access to the Internet"
    protocol        = "-1"
    to_port         = 0
    from_port = 0
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.type
  subnet_id              = var.ec2_subnet
  security_groups = [aws_security_group.ec2_sg.id]
  key_name      = aws_key_pair.public_key_to_ec2.key_name
  associate_public_ip_address = true
  user_data = base64encode(<<-EOF
#!/bin/bash
sudo dnf install -y git npm letsencrypt
sudo mkdir -p /var/www/nodejs-project; cd /var/www/nodejs-project
sudo chmod -R 775 /var/www/nodejs-project
git clone ${var.github_repo_url} .
sudo npm ci
sudo npm install -g pm2
sudo certbot certonly --standalone --preferred-challenges http \
  --non-interactive \
  --agree-tos \
  --email ${var.email} \
  -d ${var.domain}
sudo pm2 start server.mjs --watch
sudo pm2 startup
EOF
    )
  tags = {
    Name = "nodejs_server"
  }
}