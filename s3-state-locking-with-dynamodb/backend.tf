terraform {
  backend "s3" {
    bucket       = "bucketforfractice4477"
    key          = "dev/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }
}