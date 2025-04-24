module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.6"

  repository_name = "patrizia-${local.environment}-production"
  repository_type = "private"

  # Enable image scanning
  repository_image_scan_on_push = true

  # Make tags mutable
  repository_image_tag_mutability = "MUTABLE"

  # Disable lifecycle policy to avoid the error
  create_lifecycle_policy = false

  tags = merge(

    {
      Application = local.application
      Environment = local.environment
      Owner       = local.owner
      Purpose     = local.purpose
    }
  )
}