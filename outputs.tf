output "instance_public_ip" {
  description = "Elastic IP (fixo) da instancia EC2 que roda o k3s"
  value       = aws_eip.k3s_node.public_ip
}

output "ssh_command" {
  description = "Comando para conectar via SSH na instancia"
  value       = "ssh -i ~/.ssh/oficina-fiap-k3s ec2-user@${aws_eip.k3s_node.public_ip}"
}

output "kubeconfig_fetch_command" {
  description = "Comando para copiar o kubeconfig do k3s para a maquina local"
  value       = "scp -i ~/.ssh/oficina-fiap-k3s ec2-user@${aws_eip.k3s_node.public_ip}:/etc/rancher/k3s/k3s.yaml ./kubeconfig-oficina-fiap.yaml"
}

output "sqs_queue_urls" {
  description = "URL de cada fila da saga, pra usar como Secret nos repositorios dos servicos"
  value       = { for nome, fila in aws_sqs_queue.fila : nome => fila.id }
}
