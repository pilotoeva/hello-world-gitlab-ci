provider "aws" {
  region = "us-east-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["1"])

  name = "instance-${each.key}"

  ami                    = var.AMI_ID
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-0bff427d0f7e1510e"]
  subnet_id              = "subnet-59ddc857"

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp2"
      volume_size = 8
      tags = {
        Name = "my-root-block"
      }
    },
  ]
  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp2"
      volume_size = 5
      encrypted   = true
      #kms_key_id  = aws_kms_key.this.arn
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}