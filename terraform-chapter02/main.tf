terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27" # ~> hashicorp/aws 3系の.27以降の最新版を利用する
    }
  }

  required_version = ">=1.0.0" # >= Terraform 1.0.0以上を利用する
}

provider "aws" {
  profile = "default" # default以外のprofileを利用する場合はこの部分を変更
  region  = "ap-northeast-1"
}
