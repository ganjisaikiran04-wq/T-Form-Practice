resource "aws_instance" "name" {
  ami = "ami-0aa77def67762002c"
  instance_type = "t3.micro"
  tags = {
    name = "EC2-1"
  }
}