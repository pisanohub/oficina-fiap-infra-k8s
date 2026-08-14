resource "aws_key_pair" "k3s_node" {
  key_name   = "oficina-fiap-k3s-key"
  public_key = var.ssh_public_key
}
