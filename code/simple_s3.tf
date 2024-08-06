provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dev_s3" {
  bucket_prefix = "dev-"

  tags = {
    Environment          = "Dev"
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/simple_s3.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "dev_s3"
    yor_trace            = "668df04a-1ee8-4607-9279-e2746c090eda"
  }
}


