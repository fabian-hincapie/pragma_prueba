resource "aws_secretsmanager_secret" "secret_db" {
  name = "dbconnection2"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.secret_db.id
  secret_string = jsonencode(var.dbconnection)
}