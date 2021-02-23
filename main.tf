provider "aws" {
  region = var.aws_region
}


# create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc-id
}

# create a custom route table

resource "aws_route_table" "prod-route-table" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod"
  }
}
 
#create a subnet with route table

resource "aws_route_table_association" "a" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.prod-route-table.id
}

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = var.subnet_id
#  private_ips     = ["192.168.0.10"]
  security_groups = [var.sg-id]
}

#Assign an elastic ip to the network interface

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
#  associate_with_private_ip = "192.168.0.15"
  depends_on                = [aws_internet_gateway.gw]
}



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


//--------------------------------------------------------------------
// Master Key Encryption Provider instance
//    This node does not participate in the HA clustering

resource "aws_instance" "vault-transit" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.sg-id]
  associate_public_ip_address = true
  private_ip                  = var.vault_transit_private_ip
#  iam_instance_profile        = aws_iam_instance_profile.vault-transit.id

  user_data = templatefile("${path.module}/templates/userdata-vault-transit.tpl", {
    tpl_vault_zip_file     = var.vault_zip_file
    tpl_vault_service_name = "vault-${var.environment_name}"
  })

  tags = {
    Name = "${var.environment_name}-vault-transit"
  }

  lifecycle {
    ignore_changes = [
      ami,
      tags,
    ]
  }
}



// Vault Server Instance

resource "aws_instance" "vault-server" {
  count                       = length(var.vault_server_names)
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.sg-id]
  associate_public_ip_address = true
  private_ip                  = var.vault_server_private_ips[count.index]
 # iam_instance_profile        = aws_iam_instance_profile.vault-server.id

  # user_data = data.template_file.vault-server[count.index].rendered
  user_data = templatefile("${path.module}/templates/userdata-vault-server.tpl", {
    tpl_vault_node_name = var.vault_server_names[count.index],
    tpl_vault_storage_path = "/vault/${var.vault_server_names[count.index]}",
    tpl_vault_zip_file = var.vault_zip_file,
    tpl_vault_service_name = "vault-${var.environment_name}",
    tpl_vault_transit_addr = aws_instance.vault-transit.private_ip
    tpl_vault_node_address_names = zipmap(var.vault_server_private_ips, var.vault_server_names)
  })

  tags = {
    Name = "${var.environment_name}-vault-server-${var.vault_server_names[count.index]}"
  }

  lifecycle {
    ignore_changes = [ami, tags]
  }
} 
