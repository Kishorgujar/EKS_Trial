resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  tags = {
    Name = var.cluster_tag
  }

  vpc_config {
    subnet_ids          = var.subnet_ids
    security_group_ids  = var.security_group_ids
    endpoint_public_access = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = var.cluster_role_name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  role       = var.cluster_role_name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_cloudwatch_log_group" "EKS_CLUSTER_LOGS" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}
