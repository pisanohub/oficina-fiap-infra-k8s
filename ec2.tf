data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "k3s_node" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.k3s_node.id]
  key_name               = aws_key_pair.k3s_node.key_name
  iam_instance_profile   = "LabInstanceProfile"

  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  user_data = <<-EOF
    #!/bin/bash
    set -e
    curl -sfL https://get.k3s.io | sh -s - --tls-san "${aws_eip.k3s_node.public_ip}" --write-kubeconfig-mode 644
  EOF

  user_data_replace_on_change = true

  tags = {
    Name = "oficina-fiap-k3s-node"
  }
}
