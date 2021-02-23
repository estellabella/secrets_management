# AWS region and AZs in which to deploy
variable "aws_region" {
  default = "us-west-2"
}

variable "availability_zones" {
  default = "us-west-2b"
}

# All resources will be tagged with this
variable "environment_name" {
  default = "vault-deployment"
}

variable "vpc-id" {
  default = "vpc-045659f4ec33f1742"

}

variable "sg-id" {
  default = "sg-0e9026bb4a1e66ca2" 

}


#variable "lb-sg" {
 #default = "sg-0b4519bff8baa5040"
#}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "192.168.0.0/19"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "192.168.2.0/23"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "192.168.0.0/23"
}


variable "subnet_id" {
 default = "subnet-0ea1edcbe14af5fcb"

}


variable "subnet_id2" {
 default = "subnet-08a23b92852ac4758"

}


#variable "lb-subnet" {
# default = ["subnet-0931bb7744d287a49", "subnet-085b81dcc165d914e"]
#}

#variable "security_group_id" {
 #default = ""

#}
variable "vault_transit_private_ip" {
  description = "The private ip of the first Vault node for Auto Unsealing"
  default = ""
}


variable "vault_server_names" {
  description = "Names of the Vault nodes that will join the cluster"
  type = list(string)
  default = [ "vault_2", "vault_3", "vault_4" ]
}

variable "vault_server_private_ips" {
  description = "The private ips of the Vault nodes that will join the cluster"
  # @see https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html
  type = list(string)
  default = [ "192.168.10.6", "192.168.10.7", "192.168.10.8" ]
}


# URL for Vault OSS binary
variable "vault_zip_file" {
  default = "https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip"
}

# Instance size
variable "instance_type" {
  default = "t2.micro"
}

# SSH key name to access EC2 instances (should already exist) in the AWS Region
variable "key_name" {
}

