resource "aws_instance" "name" {
    ami = "ami-09c56fed07bc3afe5"
    instance_type = "t3.micro"
    user_data = file("userdata.sh")
    associate_public_ip_address = true
    tags = {
      name = "public-server"
    }
}