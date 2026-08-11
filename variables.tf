variable "aws_region" {
  description = "Regiao da AWS. O AWS Academy Learner Lab so permite us-east-1 ou us-west-2."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instancia EC2 que vai rodar o k3s."
  type        = string
  default     = "t3.medium"
}

variable "ssh_allowed_cidr" {
  description = "Faixa de IP autorizada a acessar SSH (22) e a API do Kubernetes (6443). Formato: SEU_IP/32."
  type        = string
}

variable "ssh_public_key_path" {
  description = "Caminho local da chave publica SSH a ser registrada na AWS."
  type        = string
  default     = "~/.ssh/oficina-fiap-k3s.pub"
}
