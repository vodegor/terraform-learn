provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-07651f0c4c315a529"
  subnet_id     = "subnet-0682ae7ae47957e6a"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}