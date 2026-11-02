# Filas da Saga da Ordem de Servico (ADR-P3 / ADR-P4).
# Nomes definidos em documentacao/event-storming-saga-v1.md, no repositorio principal.
locals {
  filas_saga = [
    "gerar-orcamento",      # OS -> Billing
    "orcamento-respondido", # Billing -> OS
    "processar-pagamento",  # OS -> Billing
    "pagamento-confirmado", # Billing -> OS
    "enviar-execucao",      # OS -> Execucao
    "execucao-concluida",   # Execucao -> OS
  ]
}

# Uma Dead Letter Queue por fila: mensagens que falham repetidamente na fila
# principal caem aqui em vez de ficar tentando pra sempre, pra dar pra investigar.
resource "aws_sqs_queue" "dlq" {
  for_each = toset(local.filas_saga)

  name                      = "${each.value}-dlq"
  message_retention_seconds = 1209600 # 14 dias (maximo do SQS)

  tags = {
    Name = "oficina-fiap-${each.value}-dlq"
  }
}

resource "aws_sqs_queue" "fila" {
  for_each = toset(local.filas_saga)

  name                       = each.value
  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600 # 4 dias

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[each.key].arn
    maxReceiveCount     = 5
  })

  tags = {
    Name = "oficina-fiap-${each.value}"
  }
}
