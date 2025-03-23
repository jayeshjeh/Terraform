data "aws_secretsmanager_secret" "db_secret" {
  name = "prod-db-password"
}

data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
}

resource "aws_db_subnet_group" "prod_subnet_group" {
    name      = "prod-db-subnet-group"
    subnet_ids = [aws_subnet.subnet1-public.id,
                  aws_subnet.subnet2-public.id,
                  aws_subnet.subnet3-public.id]
    tags = {
        Name = "prod-db-subnet-group"
    }   
}

resource "aws_db_instance" "prodDB" {
    identifier = "prod-db-instance"
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "8.0.40"
    instance_class = "db.t3.micro"
    db_name = "prod-db-instance"
    username = "admin"
    password = data.aws_secretsmanager_secret_version.db_secret_version.secret_string
    publicly_accessible = true
    db_subnet_group_name = aws_db_subnet_group.prod_subnet_group.name
    vpc_security_group_ids = [aws_security_group.allow_all.id]
    tags = {
        Name = "prod-db-instance"
    }
}