variable "ami_id" {
  description = "ami to launch instance"
  type = string
  default = ""

}

variable "instance_type" {
  description = "instance type to launch"
  type = string
  default = ""

}

variable "tags" {
  description = "instance tags to launch"
  type = string
  default = ""
}

variable "bucket_name" {
    description = "bucket details to create"
    type = string
    default = ""
}