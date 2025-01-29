
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "juste_kp"
}

variable "subnet_id" {
  description = "Public subnet ID"
  type        = string
  default     = "subnet-015a2a96f4d1e9ed5"
}