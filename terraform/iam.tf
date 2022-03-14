resource "aws_iam_instance_profile" "main" {
  name = "${var.base_name}-runner-ec2-profile-${data.aws_region.current.name}"
  role = aws_iam_role.gitlab_runner.name
}

resource "aws_iam_role" "gitlab_runner" {
  name = "${var.base_name}-runner-role-${data.aws_region.current.name}"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = merge({
    Name = "${var.base_name}-runner-role"
  }, var.tags)

}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}


data "aws_iam_policy_document" "gitlab_runner" {
  statement {
    actions   = var.runner_role_policy_actions
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "gitlab_runner" {
  name   = "${var.base_name}-runner-policy-${data.aws_region.current.name}"
  role   = aws_iam_role.gitlab_runner.id
  policy = data.aws_iam_policy_document.gitlab_runner.json
}
