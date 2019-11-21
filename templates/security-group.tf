locals {
  # echo "$(curl -sL icanhazip.com)/32"
  allow_ip_address = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group" "this" {
  name = local.upper_name

  vpc_id = var.vpc_id

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  // ALL
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // SSH
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = local.allow_ip_address
  }

  tags = {
    Name = local.upper_name
  }
}