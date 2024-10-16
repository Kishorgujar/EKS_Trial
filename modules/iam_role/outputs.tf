output "eks_role_arn" {
  description = "The ARN of the EKS role."
  value       = aws_iam_role.eks_role.arn
}

output "node_role_arn" {
  description = "The ARN of the Node role."
  value       = aws_iam_role.node_role.arn
}

