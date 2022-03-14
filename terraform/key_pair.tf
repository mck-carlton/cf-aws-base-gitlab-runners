resource "tls_private_key" "main" {
  algorithm = "RSA"
}

resource "aws_key_pair" "main" {
  key_name   = "${var.base_name}-runner-key"
  public_key = tls_private_key.main.public_key_openssh

  tags = merge({
    Name = "${var.base_name}-runner-key"
  }, var.tags)
}
