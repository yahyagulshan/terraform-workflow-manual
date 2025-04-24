data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# data "aws_ecrpublic_authorization_token" "token" {
#   provider = aws.virginia
# }


# data "aws_eks_cluster" "default" {
#   name       = module.eks.cluster_name
#   depends_on = [module.eks.cluster_name]
# }

# data "aws_eks_cluster_auth" "default" {
#   name       = module.eks.cluster_name
#   depends_on = [module.eks.cluster_name]
# }

data "aws_caller_identity" "current" {}