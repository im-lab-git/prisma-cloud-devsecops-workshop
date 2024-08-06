resource "aws_instance" "web_host" {
  # ec2 have plain text secrets in user data
  ami           = "${var.ami}"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
  "${aws_security_group.web-node.id}"]
  subnet_id = "${aws_subnet.web_subnet.id}"
  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMAAA
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=ap-southeast-1
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web_host"
    yor_trace            = "ed595f5f-a75e-4883-b471-5b6387c428df"
  }
}

resource "aws_ebs_volume" "web_host_storage" {
  # unencrypted volume
  availability_zone = "${var.region}a"
  #encrypted         = false  # Setting this causes the volume to be recreated on apply 
  size = 1

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web_host_storage"
    yor_trace            = "ee59c277-3228-417c-a24c-01fab7ed1ab9"
  }
}

resource "aws_ebs_snapshot" "example_snapshot" {
  # ebs snapshot without encryption
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  description = "${local.resource_prefix.value}-ebs-snapshot"

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "example_snapshot"
    yor_trace            = "d7760841-6cb4-4c3a-830b-b63722d465d8"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  instance_id = "${aws_instance.web_host.id}"
}

resource "aws_security_group" "web-node" {
  # security group is open to the world in SSH port
  name        = "${local.resource_prefix.value}-sg"
  description = "${local.resource_prefix.value} Security Group"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  depends_on = [aws_vpc.web_vpc]

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web-node"
    yor_trace            = "2494ffc9-d389-455f-a8c5-9483594d3fa6"
  }
}

resource "aws_vpc" "web_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web_vpc"
    yor_trace            = "768544ac-3a10-469c-9ab9-52a8d1b97200"
  }
}

resource "aws_subnet" "web_subnet" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true


  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web_subnet"
    yor_trace            = "de592d2b-2ef6-47a0-9316-8f1a449d3958"
  }
}

resource "aws_subnet" "web_subnet2" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.11.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true


  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web_subnet2"
    yor_trace            = "6e483502-21dd-440a-8fa3-79824c851f69"
  }
}


resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id


  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web_igw"
    yor_trace            = "58bc80de-9dc8-4c79-a326-e2baead08200"
  }
}

resource "aws_route_table" "web_rtb" {
  vpc_id = aws_vpc.web_vpc.id


  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web_rtb"
    yor_trace            = "b2237dec-8fd6-49c4-983d-457d4c95ee3e"
  }
}

resource "aws_route_table_association" "rtbassoc" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route_table_association" "rtbassoc2" {
  subnet_id      = aws_subnet.web_subnet2.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.web_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_igw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_network_interface" "web-eni" {
  subnet_id   = aws_subnet.web_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "web-eni"
    yor_trace            = "61e59229-0aaa-4b6d-a451-3608aa358e21"
  }
}

# VPC Flow Logs to S3
resource "aws_flow_log" "vpcflowlogs" {
  log_destination      = aws_s3_bucket.flowbucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.web_vpc.id


  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "vpcflowlogs"
    yor_trace            = "e067ea36-571d-4979-87ef-b4786f913b11"
  }
}

resource "aws_s3_bucket" "flowbucket" {
  bucket        = "${local.resource_prefix.value}-flowlogs"
  force_destroy = true

  tags = {
    git_commit           = "1ab908f0bf65d473d5e94ad2af711a2b0847d283"
    git_file             = "code/deployment_ec2.tf"
    git_last_modified_at = "2024-08-06 06:50:45"
    git_last_modified_by = "‘tester@tester.com’"
    git_modifiers        = "‘tester"
    git_org              = "im-lab-git"
    git_repo             = "prisma-cloud-devsecops-workshop"
    yor_name             = "flowbucket"
    yor_trace            = "75ba6127-7cda-44d4-99a4-c48fd5edd90a"
  }
}

# OUTPUTS
output "ec2_public_dns" {
  description = "Web Host Public DNS name"
  value       = aws_instance.web_host.public_dns
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.web_vpc.id
}

output "public_subnet" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet.id
}

output "public_subnet2" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet2.id
}
