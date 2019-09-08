output "cluster_name" {
  value = "${aws_eks_cluster.main_eks.name}"
}

output "worker_iam_profile_id" {
  value = "${aws_iam_instance_profile.eks_worker_role_profile.id}"
}

output "k8s_endpoint" {
  value = "${aws_eks_cluster.main_eks.endpoint}"
}
output "k8s_certificate" {
  value = "${aws_eks_cluster.main_eks.certificate_authority.0.data}"
}
output "kubectl_config" {
  value = "${data.template_file.kubectl_config.rendered}"
}

output "eks_configmap" {
  value = "${data.template_file.eks_configmap.rendered}"
}
output "join_worker_cmd" {
  value = "${data.template_file.join_worker_sh.rendered}"
}
