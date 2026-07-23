resource "aws_instance" "server" {
    ami = var.ami
    instance_type = var.instance_type
    for_each = toset(var.tags)
    tags = {
        Name = each.key
    }
  
}

