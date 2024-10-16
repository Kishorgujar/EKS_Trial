module "vpc" {
  source              = "./modules/vpc"
  region              = var.region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnet1_cidrs = ["192.168.0.0/16"]
  public_subnet2_cidrs = ["192.168.0.0/24"]
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id       = module.vpc.vpc_id
  allowed_cidrs = ["0.0.0.0/0"]  # Modify as needed for your use case
}


module "iam_roles" {
  source = "./modules/iam_role"

  eks_role_name  = "EKSRole"   # You can also use variables here
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
  subnet_ids          = concat(module.vpc.public_subnet1_ids, module.vpc.public_subnet2_ids)  # Combine both subnet IDs
  security_group_ids  = [module.security_group.security_group_id]  # Ensure this is defined
  endpoint_public_access = true
  endpoint_private_access = true
  cluster_tag         = "Cluster1"
}
