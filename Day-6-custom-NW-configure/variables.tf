variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = ""
}

variable "subnet1_cidr" {
    description = "CIDR block for subnet-1"
    type = string
    default = ""
}

variable "subnet2_cidr" {
    description = "CIDR block for subnet-2"
    type = string
    default = ""
}

variable "sg_ingress_ports" {
    description = "List of ingress ports for the security group"
    type = list(number)
    default = []
}

variable "instance_type" {
    description = "Type of the EC2 instance"
    type = string
    default = ""
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
    default     = ""
}
