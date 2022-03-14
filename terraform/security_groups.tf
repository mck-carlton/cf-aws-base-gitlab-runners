resource "aws_security_group" "gitlab_to_gitlab" {
  name   = "${var.base_name}-${var.env}-runner"
  vpc_id = data.aws_vpc.vpc[0].id

  tags = merge({
    Name = "${var.base_name}-${var.env}-runner"
  }, var.custom_tags)
}

resource "aws_security_group_rule" "gitlab_runner_inbound" {
  security_group_id = aws_security_group.gitlab_to_gitlab.id
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
}

resource "aws_security_group_rule" "gitlab_runner_outbound" {
  security_group_id = aws_security_group.gitlab_to_gitlab.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "main" {
  name        = "${var.base_name}-runner-sg"
  description = "Security group for gitlab-runner"
  vpc_id      = data.aws_vpc.vpc[0].id

  tags = merge({
    Name = "${var.base_name}-runner-sg"
  }, var.tags)
}

resource "aws_security_group_rule" "ingress_ssh" {
  description       = "Allow inbound ssh"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.main.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = local.allowed_cidrs
}

resource "aws_security_group_rule" "egress" {
  description       = "Allow outbound everything"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.main.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}