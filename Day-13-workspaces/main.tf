data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  

  tags = {
    Name = "public-instance"
  }
}


#terraform workspace
#Usage: terraform [global options] workspace

  #new, list, show, select and delete Terraform workspaces.

#Subcommands:
 #   delete    Delete a workspace
   # list      List Workspaces
   # new       Create a new workspace
  #  select    Select a workspace
  #  show      Show the name of the current workspace