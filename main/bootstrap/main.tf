### Create provider, use "aws configure --profile msk" before initial run
provider "aws" {
  version = "~> 2.68"
  region  = "eu-central-1"
  profile = "tf-stellar-core"
}

### Pass variables...
variable "tf_s3_bucket_name" {
  default = "stellar-core-tf-state"
}

variable "tf_dynamodb_locking_table" {
  default = "stellar-core-tf-lock"
}

### ...to modules
module "bootstrap" {
  source = "../../modules/bootstrap"

  tf_s3_bucket_name           = var.tf_s3_bucket_name
  tf_dynamodb_locking_table   = var.tf_dynamodb_locking_table
}