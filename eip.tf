resource "aws_eip" "k3s_node" {
  domain = "vpc"

  tags = {
    Name = "oficina-fiap-k3s-eip"
  }
}

resource "aws_eip_association" "k3s_node" {
  instance_id   = aws_instance.k3s_node.id
  allocation_id = aws_eip.k3s_node.id
}
