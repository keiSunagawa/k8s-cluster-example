variable "prefix" { type = string }

variable "main_vpc_id" { type = string }

variable "pud_subnet_items" { type = map(string) }
variable "inter_sg_id" { type = string }
variable "ssh_sg_id" { type = string }

variable "worker_iam_profile_id" { type = string }

variable "cluster_name" { type = string }

variable "k8s_endpoint" { type = string }
variable "k8s_certificate" { type = string }

variable "instance_type" { type = string }
variable "slot_price" { type = number }

variable "key_name" { type = string }
