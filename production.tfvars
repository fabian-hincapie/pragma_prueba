AWS_REGION = "us-east-1"

project     = "JFC"
environment = "PROD"

vpc_cidr               = "10.0.0.0/16"
public_subnets_cidr_a  = "10.0.0.0/25"
public_subnets_cidr_b  = "10.0.0.128/25"
private_subnets_cidr_a = "10.0.1.0/25"
private_subnets_cidr_b = "10.0.1.128/25"

ecs_cpu_front = "4096"
ecs_ram_front = "8192"
ecs_cpu_back = "4096"
ecs_ram_back = "8192"

userdb = "pragma_user"
passdb = "pragma_pass"
dbport = "5432"
instance_class_db = "db.m4.xlarge"
storage_db = "100"

dbconnection = {
    userdb = "pragma_user"
    passdb = "pragma_pass"
    dbport = "5432"
}

redisport = "6379"
node_type = "cache.m5.xlarge"