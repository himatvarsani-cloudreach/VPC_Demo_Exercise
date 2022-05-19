terraform {
    backend "s3" {
        bucket = "vpc_demo_exercise"
        key = "vpc/terraform.tfstates"
        dynamodb_table = "terraform-lock"
    }
}