variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = ""
  
}

variable "subnet1_cidr_block" {
    description = "The CIDR block for the first subnet"
    type        = string
    default     = ""
}

variable "subnet2_cidr_block" {
    description = "The CIDR block for the second subnet"
    type        = string
    default     = ""
}

variable "igw_name" {
    description = "The name of the Internet Gateway"
    type        = string
    default     = ""
}

variable "route_table_name" {
    description = "The name of the Route Table"
    type        = string
    default     = ""
}

variable "sg_name" {
    description = "The name of the Security Group"
    type        = string
    default     = ""
}

variable "ec2_instance_name" {
    description = "The name of the EC2 instance"
    type        = string
    default     = ""
}

variable "ec2_instance_ami" {
    description = "The AMI ID for the EC2 instance"
    type        = string
    default     = ""
}

variable "ec2_instance_type" {
    description = "The instance type for the EC2 instance"
    type        = string
    default     = ""
}


variable "ec2_instance_tags" {
    description = "Tags for the EC2 instance"
    type        = map(string)
    default     = {}
}


