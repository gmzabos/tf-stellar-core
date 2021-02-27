### Create S3 + DynamoDB backend
### "profile" (aka AWS environment) is mandatory to make the backend work
terraform {
  backend "s3" {
    bucket         = "stellar-core-tf-state"
    key            = "terraform.tfstate"
    dynamodb_table = "stellar-core-tf-lock"
    profile        = "tf-stellar-core"
    region         = "eu-central-1"
    encrypt        = true
  }
}