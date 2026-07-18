resource "aws_s3_bucket" "s3" {
    bucket = "bucketforfractice4477"
  
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = aws_s3_bucket.s3.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "dynamodb" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_instance" "ec2" {
    ami = "ami-0aa77def67762002c"
    instance_type = "t3.micro"
    tags = {
        Name = "public ec2"
    }
}

