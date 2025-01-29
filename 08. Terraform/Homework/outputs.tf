output "public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = aws_instance.web[*].public_ip
}

output "apache_urls" {
  description = "URLs of the Apache web servers"
  value       = [for ip in aws_instance.web[*].public_ip : "http://${ip}"]
}
