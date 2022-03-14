env               = "prod"
gitlab_account_id = "135350223673"
base_name         = "cbm-base-gitlab"
deploy_role       = "OrganizationAccountAccessRole"
runner_role_policy_actions = [
  "cloudwatch:PutMetricData",
  "ds:CreateComputer",
  "ds:DescribeDirectories",
  "ec2:DescribeInstanceStatus",
  "logs:*",
  "ssm:*",
  "ec2messages:*",
  "iam:DeleteServiceLinkedRole",
  "iam:GetServiceLinkedRoleDeletionStatus",
  "ssmmessages:CreateControlChannel",
  "ssmmessages:CreateDataChannel",
  "ssmmessages:OpenControlChannel",
  "ssmmessages:OpenDataChannel",
  "sts:AssumeRole"
]
gitlab_ami_id = "ami-0e1d30f2c40c4c701"
domain_name   = "prod.aws-provision.matter.cloud"
runner_token  = "yO819XcXE6_wA0YS"
subnet_id     = "subnet-0624622695b1fb2d4"