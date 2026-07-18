variable "db_identifier" {
    description = "name of db-identiier"
    type = string
    default = ""
}
variable "db_name" {
    description = "name od the db"
    type = string
    default = ""

}
variable "username" {
    description = "user name for sign in purpose"
    type = string
    default = ""
}
variable "password" {
    description = "password must be secret"
    type = string
    default = ""
  sensitive = true
}

variable "instance_class" {
    description = "db instance type"
    type = string
    default = ""
}
variable "allocated_storage" {
    description = "storage for db"
    type = string
    default = ""
}