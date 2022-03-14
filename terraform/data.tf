data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpcs" "vpc_list" {
  tags = {
    Name = "${var.base_name}-${local.region_short_name}-*"
  }
}

data "aws_vpc" "vpc" {
  count = length(data.aws_vpcs.vpc_list.ids)
  id    = tolist(data.aws_vpcs.vpc_list.ids)[count.index]
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc[0].id
  tags = {
    Name = "${var.base_name}-${local.region_short_name}-*-private-*"
  }
}

data "aws_subnet" "subnet0" {
  #  count = length(data.aws_subnet_ids.subnets.ids)
  id = var.subnet_id
}

locals {
  gitlab_url        = "gitlab.${var.domain_name}"
  region            = "us-east-1"
  region_short_name = "use1"
  allowed_cidrs     = [data.aws_vpc.vpc[0].cidr_block]
}