resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

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
  count = var.provisioner ? 1 : 0
  depends_on = [aws_instance.ec2_instance, aws_route53_record.dns_records]

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.ec2_instance.private_ip
    }
     inline = [
       "rm -rf learnshell",
       "git clone https://github.com/tej4360/learnshell.git",
       "cd learnshell",
       "sudo bash Roboshop/${var.component_name}.sh ${var.password} -y"
     ]
#    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}
