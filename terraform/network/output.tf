output "main_vpc_id" {
  value = "${aws_vpc.main_vpc.id}"
}

output "inter_sg_id" {
  value = "${aws_security_group.internal_sg.id}"
}

output "ssh_sg_id" {
  value = "${aws_security_group.ssh_sg.id}"
}

output "pud_subnet_items" {
  value = zipmap(aws_subnet.pub_subns.*.id, aws_subnet.pub_subns.*.availability_zone)
}
