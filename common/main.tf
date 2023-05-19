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
  records = [aws_instance.ec2_instance[${"var.component_name"}].private_ip]
}