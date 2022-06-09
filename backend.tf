terraform {
  backend "s3" {
    bucket = "vpc-demo-exercise"
    key    = "vpc/terraform.tfstates"
    #dynamodb_table = "terraform-lock"
  }
}