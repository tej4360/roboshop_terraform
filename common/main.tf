resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name

  tags = {
    Name = var.component_name
  }
}

resource "aws_route53_record" "dns_records" {
  zone_id = "Z05398713LIRV3MCPOPMB"
  name    = "${var.component_name}-dev.rtdevopspract.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2_instance.private_ip]
}

resource "null_resource" "provisioner" {
#  count = var.provisioner ? 1 : 0
  depends_on = [aws_instance.ec2_instance, aws_route53_record.dns_records]

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.ec2_instance.private_ip
    }
#     inline = [
#       "rm -rf learnshell",
#       "git clone https://github.com/tej4360/learnshell.git",
#       "cd learnshell",
#       "sudo bash Roboshop/${var.component_name}.sh ${var.password} -y"
#     ]
    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.env}.${var.component_name}-instance-profile"
  role = aws_iam_role.ssm-role.id
}

resource "aws_iam_role" "ssm-role" {
  name = "${var.env}-${var.component_name}-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "sts:AssumeRole"
        ],
        "Principal": {
          "Service": [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ssm_role_policy" {
  name = "${var.env}-${var.component_name}-policy"
  role = aws_iam_role.ssm-role.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Statement": [
      {
        "Action": [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:ssm:us-east-1:318708475688:parameter/${var.env}.${var.component_name}.*",
        "Sid": "VisualEditor0"
      },
      {
        "Action": "ssm:DescribeParameters",
        "Effect": "Allow",
        "Resource": "*",
        "Sid": "VisualEditor1"
      }
    ],
    "Version": "2012-10-17"
  })

}

