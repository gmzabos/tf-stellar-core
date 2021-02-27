### Create provider, use "aws configure --profile tf-stellar-core" before initial run
provider "aws" {
  version = "~> 2.68"
  region  = "eu-central-1"
  profile = "tf-stellar-core"
}