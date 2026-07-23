resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.instance_type
    count = length(var.tags)
    tags = {
        Name = var.tags[count.index]
    }
  
}