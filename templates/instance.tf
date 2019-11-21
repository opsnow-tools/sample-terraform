locals {
    key_name = "SEOUL-DEV-IAC-DEMO"
    public_key_path = "~/.ssh/id_rsa.pub"
    instance_type = "t2.nano"
}

resource "aws_key_pair" "this" {
  count      = local.public_key_path != "" ? 1 : 0
  key_name   = local.key_name
  public_key = file(local.public_key_path)
}

resource "aws_instance" "this" {
  ami                  = data.aws_ami.this.id
  instance_type        = local.instance_type != "" ? local.instance_type : "t2.micro"
#   subnet_id            = local.subnet_id

  vpc_security_group_ids = [
    aws_security_group.this.id,
  ]

  key_name = local.key_name

  tags = {
    Name = "${local.upper_name}-DEMO"
    Type = "bastion"
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id

  vpc = true

  tags = {
    Name = local.upper_name
  }
}