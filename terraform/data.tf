data "aws_availability_zones" "availability_zones" {
  state = "available"
}

data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "amzn2-ami-ecs-*" ##ECS optimized image
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  owners = [
    "amazon"
  ]
}

data "template_file" "user_data" {
  template = file("user-data.sh")

  vars = {
    ecs_cluster_name = var.cluster_name
  }
}