terraform {
  backend "s3" {
    bucket         = "bucketforfractice477"
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraformlock"
  }
}