resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.ec2_ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = "frontend"
  }
}
