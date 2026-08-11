output "instance_public_ip" {
  description = "IP publico da instancia EC2 que roda o k3s"
  value       = aws_instance.k3s_node.public_ip
}

output "ssh_command" {
  description = "Comando para conectar via SSH na instancia"
  value       = "ssh -i ~/.ssh/oficina-fiap-k3s ec2-user@${aws_instance.k3s_node.public_ip}"
}

output "kubeconfig_fetch_command" {
  description = "Comando para copiar o kubeconfig do k3s para a maquina local"
  value       = "scp -i ~/.ssh/oficina-fiap-k3s ec2-user@${aws_instance.k3s_node.public_ip}:/etc/rancher/k3s/k3s.yaml ./kubeconfig-oficina-fiap.yaml"
}
