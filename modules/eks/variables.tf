variable "region" {
  description = "The AWS region where the EKS cluster will be created."
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role to be used by the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The desired Kubernetes version."
  type        = string
  default     = "1.29"  # Change this to the desired version
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS cluster will run."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EKS cluster."
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "Whether to enable public access to the EKS cluster API server."
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Whether to enable private access to the EKS cluster API server."
  type        = bool
  default     = true
}

variable "cluster_tag" {
  description = "Tag for the EKS cluster."
  type        = string
  default     = "Cluster1"
}

