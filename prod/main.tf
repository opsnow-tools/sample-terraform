# main
terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "seoul-felix-sample-terraform-state"
    key    = "sample-terraform-prod.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}