locals {
  application = "yahya"
  owner       = "yahya"
  purpose     = "yahya-env"
  stack_name  = "yahya"
  environment = "yahya"


  # name   = "patrizia-${basename(path.cwd)}"
  name   = "yahya-${substr(basename(path.cwd), 0, 8)}"
  region = "us-east-1"

  vpc_cidr = "10.100.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  github_projects = [
    "yahya-backend",
    "yahya-frontend"
  ]

  username = "yahya-admin"
  userarn  = "arn:aws:iam::960742198541:user/yahya-admin"
  rolearn      = "arn:aws:iam::960742198541:role/oidc-role-for-oidc-authentication-repo"
  account_id     = "960742198541"

  vpc_id = module.vpc.vpc_id
  database_subnets = module.vpc.database_subnets
}
