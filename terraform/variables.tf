variable "region" {
  description = "AWS Region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "gitlab_account_id" {
  description = "Gitlab account ID to deploy to"
  type        = string
}

variable "env" {
  description = "Environment to be used for deploy. Prod/NonProd/Dev"
  type        = string
  default     = "dev"
}

variable "base_name" {
  description = "Base name to be appended to all resources"
  type        = string
}

variable "custom_tags" {
  description = "Custom tags which can be passed on to the AWS resources. They should be key value pairs having distinct keys"
  type        = map(any)
  default     = {}
}

variable "runner_role_policy_actions" {
  description = "IAM policy of allowed actions for the Gitlab runner"
  type        = list(string)
  default     = []
}

variable "gitlab_ami_id" {
  description = "EC2 AMI ID for gitlab environment"
  type        = string
}

variable "domain_name" {
  description = "Pre-existing DNS name for the gitlab. Eg: domain_name = spike.mckinsey.cloud, results in FQDN git.spike.mckinsey.cloud"
  type        = string
}

variable "runner_token" {
  description = "Gitlab runner registration token. Needed to register runner with host Gitlab server."
  type        = string
}

variable "subnet_id" {
  description = "Private subnet to be used to deploy gitlab runners"
  type        = string
}

variable "deploy_role" {
  description = "Role to be assumed by CI pipeline to deploy terraform code"
  type        = string
}

#variable "key_type" {
#  description = "Indicate which kind of key to create: 'service' for key used by services; 'direct' for other keys. Must provide service_key or direct_key maps depending on the type"
#  type        = string
#  default = "service"
#}

variable "tags" {
  description = "Tags which can be passed on to the AWS resources. They should be key value pairs having distinct keys."
  type        = map(string)
  default     = {}
}