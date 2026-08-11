resource "aws_security_group" "k3s_node" {
  name        = "oficina-fiap-k3s-sg"
  description = "Security group da instancia EC2 que roda o k3s"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH - apenas do IP autorizado"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "API do Kubernetes - apenas do IP autorizado"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "Trafego HTTP da aplicacao - publico"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permite todo trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "oficina-fiap-k3s-sg"
  }
}
