provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dev_s3" {
  bucket_prefix = "dev-"

  tags = {
    Environment          = "Dev"
    yor_name             = "dev_s3"
    yor_trace            = "32802301-51d4-468c-8e59-a41b3a9b3880"
    git_commit           = "7b8e286dd4e87e26c708eab7aa61cacbad59570b"
    git_file             = "code/build/s3.tf"
    git_last_modified_at = "2024-08-06 08:01:01"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
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
