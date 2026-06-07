variable "state_bucket_name" {
  description = "Tên S3 bucket để lưu Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Tên DynamoDB table cho state locking"
  type        = string
  default     = "terraform-state-locks"
}