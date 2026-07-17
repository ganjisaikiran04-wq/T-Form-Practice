module "test" {
    source = "git::https://github.com/ganjisaikiran04-wq/T-Form-Practice.git//Day-9-module-source"
    cidr_block = "10.0.0.0/16"
    subnet1_cidr_block = "10.0.1.0/24"
    subnet2_cidr_block = "10.0.2.0/24"
    igw_name = "IGW"
    route_table_name = "RouteTable"
    sg_name = "SecurityGroup"
    ec2_instance_ami = "ami-0aa77def67762002c"
    ec2_instance_type = "t3.micro"
    ec2_instance_name = "EC2Instance"

}
 