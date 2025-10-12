variable "aws_region" {
  description = "AWS region to deploy in"
  default = "eu-north-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair for SSH access"
  default = "terraform-lab-key"  # Change this to your actual key name
}
