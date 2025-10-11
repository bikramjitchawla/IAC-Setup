variable "aws_region" {
    description = "aws REGION TO DEPLOY"
    default = "eu-central-1"

}

variable "instance_type" {
    description = "Ec2 instance type"
    default = "t3.micro"

}

variable "key_name"{
    description = "Existing aws key pair"
    default = "my-keypair"

}
   
