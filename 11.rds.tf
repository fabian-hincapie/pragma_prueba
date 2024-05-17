resource "aws_db_instance" "primary" {
  allocated_storage          = var.storage_db
  auto_minor_version_upgrade = false
  engine                     = "mysql"
  identifier              = "db-primary"
  instance_class          = var.instance_class_db
  backup_retention_period = 7
  publicly_accessible     = false
  multi_az                = true
  password                = var.passdb
  username                = var.userdb
  port                    = var.dbport
  apply_immediately       = true
  db_subnet_group_name    = aws_db_subnet_group.db_grp.name
  vpc_security_group_ids  = ["${aws_security_group.db.id}"]
  skip_final_snapshot     = true

  tags = {
    Name        = "db-primary-${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_db_instance" "test-replica" {
  replicate_source_db = aws_db_instance.primary.identifier
  #replica_mode                = "mounted"
  engine                     = "mysql"
  auto_minor_version_upgrade = false
  identifier                 = "db-replica"
  instance_class             = var.instance_class_db
  multi_az                   = true
  skip_final_snapshot        = true

  tags = {
    Name        = "db-replic-${var.project}"
    Environment = "${var.environment}"
  }
}


resource "aws_db_subnet_group" "db_grp" {
  name       = "db_grp_vpc_jfc"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]

  tags = {
    Name = "My DB subnet group"
  }
}