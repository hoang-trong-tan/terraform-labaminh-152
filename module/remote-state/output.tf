output "state_bucket_name" {
  description = "Tên S3 bucket chứa Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_arn" {
  description = "ARN của S3 bucket chứa Terraform state"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  description = "Tên DynamoDB table dùng cho state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}