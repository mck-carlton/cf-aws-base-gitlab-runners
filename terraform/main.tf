module "gitlab_runner" {
  source = "git::https://github.com/reactorworks/cf-aws-submodules//terraform-aws-cf-gitlab-runner"
  count  = 2

  gitlab_ami_id               = var.gitlab_ami_id
  subnet_id                   = data.aws_subnet.subnet0.id
  base_name                   = var.base_name
  registration_token          = var.runner_token
  gitlab_url                  = local.gitlab_url
  runner_role_policy_actions  = var.runner_role_policy_actions
  security_group_ids          = [aws_security_group.gitlab_to_gitlab.id, aws_security_group.main.id]
  env                         = var.env
  kms_key_id                  = module.gitlab_runner_key.key_id
  instance_key_pair           = aws_key_pair.main.key_name
  instance_profile_name       = aws_iam_instance_profile.main.name
}

module "gitlab_runner_key" {
  source = "git::https://github.com/reactorworks/cf-aws-submodules//terraform-aws-cf-kms-key"

  alias_name           = "${var.base_name}-runner-ebs-volume-key"
  append_random_suffix = true
  key_type             = "service"
  description          = "Used to encrypt root volume for gitlab runner instance"
  tags                 = var.tags

  service_key_info = {
    "aws_service_names"  = [format("ec2.%s.amazonaws.com", data.aws_region.current.name)]
    "caller_account_ids" = [data.aws_caller_identity.current.account_id]
  }
}