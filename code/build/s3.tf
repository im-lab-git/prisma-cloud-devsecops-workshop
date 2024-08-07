provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dev_s3" {
  bucket_prefix = "dev-"
  acl           = "public-read-write"

  tags = {
    Environment          = "Dev"
    yor_name             = "dev_s3"
    yor_trace            = "32802301-51d4-468c-8e59-a41b3a9b3880"
    git_commit           = "bbd2b30c7cde8e16b67b626ab18d6aabd937ce06"
    git_file             = "code/build/s3.tf"
    git_last_modified_at = "2024-08-07 01:25:13"
    git_last_modified_by = "james.yau@ingrammicro.com"
    git_modifiers        = "james.yau/‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    sample_name          = "sample"
  }
}

resource "aws_s3_bucket_ownership_controls" "dev_s3" {
  bucket = aws_s3_bucket.dev_s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
