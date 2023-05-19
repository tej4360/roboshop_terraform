resource "aws_instance" "app_instance" {
  depends_on = [aws_instance.db_instance]
  for_each = var.app_servers
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = each.value["type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_instance" "db_instance" {
  for_each = var.db_servers
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = each.value["type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "app_route53" {
  depends_on = [aws_instance.app_servers]
  for_each = var.app_servers
  zone_id = "Z05398713LIRV3MCPOPMB"
  name    = "${each.key}rtdevopspract.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.aws_instance[each.value["name"]].private_ip]
}

resource "aws_route53_record" "db_route53" {
  depends_on = [aws_instance.db_instance]
  for_each = var.db_servers
  zone_id = "Z05398713LIRV3MCPOPMB"
  name    = "${each.key}rtdevopspract.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.aws_instance[each.value["name"]].private_ip]
}