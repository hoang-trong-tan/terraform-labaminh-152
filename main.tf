terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.47.0"
    }
  }

  backend "s3" {
    bucket         = "labaminh-remote-state-check1"   # ← bucket đã tồn tại
    key            = "lab/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }

}

provider "aws" {
  region = "ap-southeast-1"
}




module "my_vpc" {
  source   = "./module/vpc"
  vpc_cidr = "10.0.0.0/16"

  subnets = var.subnets

  vpc_tag = var.vpc_tag
}

module "my_ec2" {
  source            = "./module/ec2"
  subnet_id_for_ec2 = module.my_vpc.all_subnets["public_subnet_1"].id
  sg_id_for_ec2     = module.my_vpc.public_sg_id
}



module "rds" {
  source      = "./module/rds"
  username_db = var.username_db
  password_db = var.password_db
  rds_sg_id   = module.my_vpc.sg_rds
  private_subnet_ids = [
    for k, v in module.my_vpc.all_subnets : v.id if v.tags["Tier"] == "private"
  ]
}

module "s3" {
  source  = "./module/s3"
  name_bk = "my-bucket-for-lab-tonight"
  s3_tag = var.s3_tag
}

module "remote_state" {
  source              = "./module/remote-state"
  state_bucket_name   = "labaminh-terraform-state1"
  dynamodb_table_name = var.dynamodb_table_name
}