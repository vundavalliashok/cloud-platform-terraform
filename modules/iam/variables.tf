variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in owner/repository format."
  type        = string
  default     = ""
}

variable "create_github_oidc" {
  description = "Whether to create GitHub Actions OIDC resources."
  type        = bool
  default     = false
}
variable "eks_oidc_provider_arn" {
  description = "EKS OIDC provider ARN."
  type        = string
  default     = ""
}

variable "eks_oidc_provider_url" {
  description = "EKS OIDC provider URL without https://."
  type        = string
  default     = ""
}
resource "aws_iam_role" "eks_workload" {
  count = var.eks_oidc_provider_arn != "" ? 1 : 0

  name = "${var.project_name}-${var.environment}-eks-workload"

  assume_role_policy = data.aws_iam_policy_document.eks_workload_assume_role[0].json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-eks-workload"
    }
  )
}

resource "aws_iam_role_policy" "eks_workload_secrets" {
  count = var.eks_oidc_provider_arn != "" ? 1 : 0

  name = "${var.project_name}-${var.environment}-secrets-access"

  role = aws_iam_role.eks_workload[0].id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = "arn:aws:secretsmanager:*:${data.aws_caller_identity.current.account_id}:secret:${var.project_name}/${var.environment}/*"
      }
    ]
  })
}

