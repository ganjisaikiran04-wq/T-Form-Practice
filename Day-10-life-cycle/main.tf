resource "aws_instance" "name" {
    ami = "ami-0aa77def67762002c"
    instance_type = "t3.micro"
    tags = {
      name = "public-server"
    }
    lifecycle {
        prevent_destroy = true
      }
}






       # lifecycle {
      #  ignore_changes = [ tags ]
    #}

    #lifecycle {
     # create_before_destroy = true
    #}


