output "server_public_ip" {
  value = aws_instance.conda-instance.public_ip
}