data "aws_ami" "linux" {
  most_recent = true
  owners = ["137112412989"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
  
}


resource "aws_instance" "public_instance" {
  ami = data.aws_ami.linux.id
  instance_type = var.instance_type
  subnet_id = var.subnet_id_for_ec2
  vpc_security_group_ids = [var.sg_id_for_ec2]
}