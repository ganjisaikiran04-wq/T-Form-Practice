resource "aws_s3_bucket" "bicket" {
  bucket = "bucketforpractice47"

  tags = {
    Name        = "bucketforpractice47"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_acl" "bicket_acl" {
  bucket = aws_s3_bucket.bicket.id
  acl    = "private"
}
