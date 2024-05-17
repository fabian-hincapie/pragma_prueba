AWS_REGION = "us-east-1"

project     = "JFC"
environment = "TEST"

vpc_cidr               = "11.0.0.0/16"
public_subnets_cidr_a  = "11.0.0.0/25"
public_subnets_cidr_b  = "11.0.0.128/25"
private_subnets_cidr_a = "11.0.1.0/25"
private_subnets_cidr_b = "11.0.1.128/25"

ecs_cpu_front = "1024"
ecs_ram_front = "2048"
ecs_cpu_back = "1024"
ecs_ram_back = "2048"

userdb = "pragma_user"
passdb = "pragma_pass"
dbport = "5432"
instance_class_db = "db.t3.micro"
storage_db = "20"

dbconnection = {
    userdb = "pragma_user"
    passdb = "pragma_pass"
    dbport = "5432"
}

redisport = "6379"
node_type = "cache.m4.large"