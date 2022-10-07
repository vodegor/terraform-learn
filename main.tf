provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_security_group" "instance" {
  name   = "terraform-example-instance"
  vpc_id = "vpc-0b4b5f08822988a69"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-07651f0c4c315a529"
  subnet_id              = "subnet-0682ae7ae47957e6a"
  vpc_security_group_ids = [aws_security_group.instance.id]
  instance_type          = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}