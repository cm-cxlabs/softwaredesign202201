# セキュリティグループ
resource "aws_security_group" "example_ec2_sg" {
  name        = "example-ec2-sg"
  description = "EC2 Security Group"
  vpc_id      = aws_vpc.example_vpc.id

  tags = {
    Name = "example-ec2-sg"
  }
}

# 外部からHTTP80ポートへの通信を許可
resource "aws_security_group_rule" "example_ec2_in_http" {
  security_group_id = aws_security_group.example_ec2_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

# Webサーバーから外部への通信を許可
resource "aws_security_group_rule" "example_ec2_out" {
  security_group_id = aws_security_group.example_ec2_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# EC2インスタンス
resource "aws_instance" "example_ec2" {
  instance_type = "t2.micro"
  ami           = "ami-02d36247c5bc58c23"
  subnet_id     = aws_subnet.example_subnet_a.id
  vpc_security_group_ids = [
    aws_security_group.example_ec2_sg.id,
  ]
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
uname -n > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
EOF

  tags = {
    Name = "example-ec2"
  }
}

