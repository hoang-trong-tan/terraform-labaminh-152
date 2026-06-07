output "web_server_public_ip" {
  description = "Địa chỉ public ip của ec2 để truy cập web"
  value       = module.my_ec2.ec2_ip
}

output "rds_endpoint" {
  description = "URL Kết nối RDS"
  value       = module.rds.rds_endpoint
}

# 3. Thông tin bảo mật (Che giấu khi in ra màn hình)
output "rds_admin_username" {
  description = "Tên đăng nhập Admin của Database"
  value       = var.username_db
}

output "rds_admin_password" {
  description = "Mật khẩu Admin của Database"
  value       = var.password_db
  sensitive   = true # BẮT BUỘC: Che giấu giá trị này trên màn hình
}

output "s3_bucket_name" {
  description = "Tên S3 Bucket"
  value       = module.s3.name_bucket
}


output "terraform_state_bucket" {
  description = "S3 bucket chứa Terraform state"
  value       = module.remote_state.state_bucket_name
}

output "terraform_lock_table" {
  value       = module.remote_state.dynamodb_table_name
  description = "DynamoDB Table cho stable locking" 
}