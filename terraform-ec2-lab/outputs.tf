output "instance_public_ip" {
    description = "public ip of ec2 instance"
    value = aws_instance.lab_instance.public_ip
}

output "vpc_id" {
    value = aws_vpc.lab_vpc.id
}