module "vpc" {
  source              = "./modules/vpc"
  region              = var.region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_pub_subnet1_cidrs = ["192.168.0.0/20"]
  public_pub_subnet2_cidrs = ["192.168.16.0/20"]
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  allowed_cidrs = ["0.0.0.0/0"]  # Modify as needed
}

module "iam_roles" {
  source = "./modules/iam_role"
  eks_role_name  = "EKSRole"
  eks_role_tag   = "EKS"
  node_role_name = "NodeRole"
  node_role_tag  = "NodeGroup"
}

module "eks" {
  source              = "./modules/eks"
  region              = var.region
  cluster_name        = var.cluster_name
  cluster_role_arn    = module.iam_roles.eks_role_arn
  kubernetes_version  = var.kubernetes_version
  cluster_role_name    = "EKSRole"
  
  # Pass subnet IDs from the VPC module
  subnet_ids = concat(
    module.vpc.public_pub_subnet1_ids,
    module.vpc.public_pub_subnet2_ids
  )
  
  security_group_ids  = [module.security_group.security_group_id]
  endpoint_public_access = true
  endpoint_private_access = true
  cluster_tag         = "Cluster1"
}

