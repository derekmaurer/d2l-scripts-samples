provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

provider "aws" {
  alias = "partitions"

  # region should match the region to which partitions are being deployed
  #   generally one of:
  #     us-east-1
  #     ca-central-1
  #     eu-west-1
  #     ap-southeast-1
  #     ap-southeast-2
  region = "us-east-1"

  # choose the appropriate role for dev or prd partitions
  #   arn:aws:iam::215354123741:role/d2l-ear-partition-info-reader-dev
  #   arn:aws:iam::572755843338:role/d2l-ear-partition-info-reader-prd
  assume_role {
    role_arn = "arn:aws:iam::215354123741:role/d2l-ear-partition-info-reader-dev"
  }
}