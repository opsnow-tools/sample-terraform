# main
terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "seoul-okc2-sample-terraform-state"
    key    = "sample-terraform-dev.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

