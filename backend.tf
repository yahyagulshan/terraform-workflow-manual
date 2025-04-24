# ##########################################
# ##  AWS terraform Remote Backend Config ##
# ##########################################

terraform {
  backend "s3" {
    region         = "us-east-1"                                      # Terraform Backend AWS regions (Need to update the key to the account name)
    key            = "vpc/terraform.tfstate"                          # S3 bucket directoy structure for terraform state file to store
    bucket         = "yahya-patch-production-terraform-backend-us-east-1"      # Update S3 bucket name output from terraform backend script
    dynamodb_table = "yahya-patch-production-terraform-backend-us-east-1.lock" # Update DynamoDB name output from terraform backend script
    encrypt        = true
  }

  required_version = ">= 1.0.5"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.7"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }
}


# ####################################
# ##  AWS terraform Provider Config ##
# ####################################

provider "aws" {

  region = local.region

  default_tags {
    tags = {
      Application = "${local.application}"
      Owner       = "${local.owner}"
      Purpose     = "${local.purpose}"
      Stack       = "${local.stack_name}"
      Terraform   = "true"
      Environment = "${local.environment}"
    }
  }

}


provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}

# provider "helm" {
#   kubernetes {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       # This requires the awscli to be installed locally where Terraform is executed
#       args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#     }
#   }
# }

# provider "kubectl" {
#   apply_retry_count      = 5
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   load_config_file       = false

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     # This requires the awscli to be installed locally where Terraform is executed
#     args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }

# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     # This requires the awscli to be installed locally where Terraform is executed
#     args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }