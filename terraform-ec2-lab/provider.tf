terraform{
    required_provider{
        aws = {
          source = "hashicor/aws"
          version = "5.0"
        }
    }

    required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region

}

