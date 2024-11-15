output "rds_hostname" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.iot.address
}

output "rds_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.iot.port
}

output "rds_username" {
  description = "The username for the RDS instance"
  value       = aws_db_instance.iot.username
}
