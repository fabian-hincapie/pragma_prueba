resource "aws_elasticache_subnet_group" "elasticache_grp_priv" {
  name       = "elasticache-grp-priv"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = var.redisport
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_grp_priv.name
  security_group_ids   = [aws_security_group.cache.id]

  tags = {
    Name        = "cache-${var.project}"
    Environment = "${var.environment}"
  }
}