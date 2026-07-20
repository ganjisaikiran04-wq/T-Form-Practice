data "aws_subnet" "name" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet"]
  }
}

data "aws_security_group" "name" {
    filter {
      name   = "tag:Name"
      values = ["security-group"]
    }
}

data "aws_ami" "amazon-linux" {
    most_recent = true
    owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
             filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
        filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

resource "aws_instance" "name" {
    ami = data.aws_ami.amazon-linux.id
    instance_type = "t3.micro"
    subnet_id = data.aws_subnet.name.id
    vpc_security_group_ids = [data.aws_security_group.name.id]
  
}

#from the data source we need to check amis to overcome asg issue