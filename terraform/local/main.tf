provider "aws" {
  region = "ap-northeast-1" # Tokyo
}

locals {
  prefix = "kerfume-local"
}

module "m_network" {
  source = "../network"

  prefix = "${local.prefix}"
}

module "m_eks" {
  source = "../eks"

  prefix           = "${local.prefix}"
  main_vpc_id      = "${module.m_network.main_vpc_id}"
  pud_subnet_items = "${module.m_network.pud_subnet_items}"
  inter_sg_id      = "${module.m_network.inter_sg_id}"
}

module "m_worker" {
  source = "../worker_autoscaling"

  prefix                = "${local.prefix}"
  main_vpc_id           = "${module.m_network.main_vpc_id}"
  pud_subnet_items      = "${module.m_network.pud_subnet_items}"
  inter_sg_id           = "${module.m_network.inter_sg_id}"
  ssh_sg_id             = "${module.m_network.ssh_sg_id}"
  worker_iam_profile_id = "${module.m_eks.worker_iam_profile_id}"
  cluster_name          = "${module.m_eks.cluster_name}"
  k8s_endpoint          = "${module.m_eks.k8s_endpoint}"
  k8s_certificate       = "${module.m_eks.k8s_certificate}"
  instance_type         = "t2.large"
  slot_price            = 0.09 # ondemand is 0.0928USD
  key_name              = "kerfume_key"
}

output "kubectl_config" {
  value = "${module.m_eks.kubectl_config}"
}

output "eks_configmap" {
  value = "${module.m_eks.eks_configmap}"
}
