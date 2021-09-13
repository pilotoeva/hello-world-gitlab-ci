terraform {
  backend "s3" {
    bucket = "terraform-remote-state-def"
    key    = "terraform-state-packer-aws-with-gitlab.tfstate"
    region = "eu-west-1"
  }
}
