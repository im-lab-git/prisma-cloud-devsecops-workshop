resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  force_destroy = true

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_s3.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "data"
    yor_trace            = "9142c5e8-0f18-41e9-adc2-f8258d8a49fc"
  }
}

resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_s3.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "data_object"
    yor_trace            = "f5e355c0-880f-4dac-a03a-bbc98d802fef"
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  acl           = "private"
  force_destroy = true

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_s3.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "financials"
    yor_trace            = "d92b2047-1b4a-4ee8-b081-c929cffe30b2"
  }
}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket = "${local.resource_prefix.value}-operations"
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_s3.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "operations"
    yor_trace            = "61760708-a2dd-4274-8c78-64f929451292"
  }
}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_s3.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "data_science"
    yor_trace            = "e37cc009-dc1e-4e0b-bea6-23aae11abca0"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }
  force_destroy = true

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_s3.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "logs"
    yor_trace            = "3939c0e3-325a-472c-b70b-48c98d479ece"
  }
}
