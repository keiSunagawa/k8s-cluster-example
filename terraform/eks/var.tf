variable "prefix" { type = string }

variable "main_vpc_id" { type = string }

variable "pud_subnet_items" { type = map(string) }

variable "inter_sg_id" { type = string }
