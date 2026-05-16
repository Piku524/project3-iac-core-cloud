resource "aws_security_group" "database" {
  name        = "project3-database-security-group"
  description = "Allow MySQL only from web security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL from web server"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_security_group_id]
  }

  egress {
    description = "Allow outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project3-database-security-group"
  }
}

resource "aws_db_subnet_group" "database" {
  name       = "project3-database-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "project3-database-subnet-group"
  }
}

resource "aws_db_instance" "database" {
  identifier              = "project3-database"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp3"
  db_name                 = "project3db"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.database.name
  vpc_security_group_ids  = [aws_security_group.database.id]
  publicly_accessible     = false
  storage_encrypted       = true
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "project3-database"
  }
}
