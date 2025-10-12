resource "aws_vpc" "lab_vpc" {
    cidr_block =  "10.0.0.0/16"
    tags = {
        Name = "terraform-lab-vpc"
    }
}

resource "aws_subnet" "lab_subnet" {
    vpc_id = aws_vpc.lab_vpc.id
    cidr_block        = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-north-1a"
    tags = {
        Name = "terraform-lab-subnet"
    }
}

resource "aws_internet_gateway" "lab_igw" {
    vpc_id = aws_vpc.lab_vpc.id
    tags = {
        Name= "terraform-lab-igw"
    }
}

resource "aws_route_table" "lab_rt"{
    vpc_id = aws_vpc.lab_vpc.id
    route {
        cidr_block = "0.0.0.0/16"
        gateway_id = aws_internet_gateway.lab_igw.id
    }
}

# associate route table with subnet 

resource "aws_route_table_association" "lab_rta"{
    subnet_id = aws_subnet.lab_subnet.id
    route_table_id = aws_route_table.lab_rt.id

}

# security group 
resource "aws_security_group" "lab_sg" {
  name        = "terraform-lab-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-lab-sg"
  }
}

resource "aws_instance" "lab_instance"{
    ami = "ami-0d4d7e98021b6b9a6"
    instance_type = var.instance_type
    subnet_id = aws_subnet.lab_subnet.id
    vpc_security_group_ids = [aws_security_group.lab_sg.id]
    key_name = var.key_name

    tags = {
        Name = "terraform-lab-instance"
    }
}