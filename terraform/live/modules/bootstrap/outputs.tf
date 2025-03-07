output "terraform_state_bucket_domain_name" {
  value = aws_s3_bucket.terraform_state_bucket.bucket_domain_name
}

output "terraform_state_lock_name" {
  value = aws_dynamodb_table.terraform_state_lock.name
}
