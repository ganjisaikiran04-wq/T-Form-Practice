resource "aws_instance" "name" {
    ami = "ami-0aa77def67762002c"
    instance_type = "t3.micro"
    tags = {
      name = "server-1"
    }
  
}

resource "aws_s3_bucket" "name" {
    bucket = "buckerforfractice4477"
  
}

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.name.id

  versioning_configuration {
    status = "Enabled"
  }
}

#terraform import aws.instance.name instance id
#terraform import aws_s3_bucket_versioning.name bucket name
#terraform import aws_s3_bucket.name bucket name