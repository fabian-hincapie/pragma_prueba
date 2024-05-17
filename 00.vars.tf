variable "AWS_REGION" {}

variable "project" {}
variable "vpc_cidr" {}
variable "environment" {}

variable "public_subnets_cidr_a" {}
variable "public_subnets_cidr_b" {}
variable "private_subnets_cidr_a" {}
variable "private_subnets_cidr_b" {}

variable "ecs_cpu_front" {}
variable "ecs_ram_front" {}
variable "ecs_cpu_back" {}
variable "ecs_ram_back" {}

variable "userdb" {}
variable "passdb" {}
variable "dbport" {}
variable "instance_class_db" {}
variable "storage_db" {}
variable "dbconnection" {
  type = map(string)
}

variable "redisport" {}
variable "node_type" {}