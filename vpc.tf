module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 5, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 5, k + 16)]
  database_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 5, k + 20)]

  enable_nat_gateway = false
  single_nat_gateway = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    # Tags subnets for Karpenter auto-discovery
    "karpenter.sh/discovery" = local.name
  }


}
