terraform {
  backend "s3" {
    bucket         = "bucketforfractice4477"
    key            = "bucketforfractice4477"
    region         = "ap-southeast-2"
    dynamodb_table = "terraformlock"
  }
}