resource "aws_instance" "app_instance" {
  for_each = var.app_servers
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = each.value["type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_instance" "db_instance" {
  for_each = var.db_instance_servers
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = each.value["type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = each.value["name"]
  }
}