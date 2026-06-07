resource "aws_s3_bucket" "static_bucket" {
    bucket = var.name_bk

    tags = var.s3_tag
}