resource "aws_s3_bucket" "terraform_state_bucket" {
    bucket = "tf-state-${local.environment_prefix}"
    tags = var.tags
}

resource "aws_s3_bucket_ownership_controls" "terraform_state_bucket_ownership" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_bucket_acl" {
  depends_on = [ aws_s3_bucket_ownership_controls.terraform_state_bucket_ownership ]

  bucket = aws_s3_bucket.terraform_state_bucket.id
  acl = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "tf-state-lock"
  billing_mode = "PROVISIONED"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  read_capacity = 1
  write_capacity = 1

  tags = var.tags
}