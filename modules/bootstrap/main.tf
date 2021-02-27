### Incoming variables from main/bootstrap/main.tf
variable "tf_s3_bucket_name" {}
variable "tf_dynamodb_locking_table" {}

### Create KMS key to encrypt
resource "aws_kms_key" "tf-state-key" {
  description               = "KMS key to encrypt tfstate"
  deletion_window_in_days   = 10

  tags = {
    Name          = "terraform-state-key"
    Owner         = ""
    Environment   = ""
    TF-Managed    = "true"
    TF-Bootstrap  = "true"
  }
}

### Create S3 bucket to store tfstate
resource "aws_s3_bucket" "tf-state-bucket" {
  bucket            = var.tf_s3_bucket_name

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.tf-state-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name          = var.tf_s3_bucket_name
    Owner         = ""
    Environment   = ""
    TF-Managed    = "true"
    TF-Bootstrap  = "true"
  }
}

### Create DynamoDB table to store lock files
resource "aws_dynamodb_table" "tf-locking-table" {
  name                = var.tf_dynamodb_locking_table
  hash_key            = "LockID"
  read_capacity       = 20
  write_capacity      = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name          = var.tf_dynamodb_locking_table
    Owner         = ""
    Environment   = ""
    TF-Managed    = "true"
    TF-Bootstrap  = "true"
  }
}
