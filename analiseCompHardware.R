
lambda_estimado <- 3.8

dias_no_mes <- 30
minutos_por_dia <- 24 * 60
minutos_no_mes <- dias_no_mes * minutos_por_dia

# simulação de ocorrências

set.seed(123)

simulacao_mensal <- rpois(
  n = minutos_no_mes,
  lambda = lambda_estimado
)

#histórico

historico_hardware <- data.frame(
  Minuto = 1:minutos_no_mes,
  Eventos = simulacao_mensal
)

limite_alerta <- ceiling(
  lambda_estimado + 3 * sqrt(lambda_estimado)
)

historico_hardware$Status <- ifelse(
  historico_hardware$Eventos > limite_alerta,
  "ALERTA (Sobrecarga)",
  "Normal"
)

# qtd alertas
quantidade_alertas <- sum(
  historico_hardware$Status == "ALERTA (Sobrecarga)"
)
percentual_alertas <- (
  quantidade_alertas / minutos_no_mes
) * 100

cat("---- sumário ----\n")

cat("Média de eventos por minuto:", lambda_estimado, "\n")
cat("Limite estatístico de alerta:", limite_alerta, "\n")
cat("Total de minutos simulados:", minutos_no_mes, "\n")
cat("Quantidade de alertas:", quantidade_alertas, "\n")

cat(
  "Percentual de alertas:",
  round(percentual_alertas, 2),
  "%\n"
)

# seleciona os primeiros 300 minutos para o gráfico

amostra_grafico <- historico_hardware[1:300, ]



plot(
  amostra_grafico$Minuto,
  amostra_grafico$Eventos,
  type = "h",
  col = ifelse(
    amostra_grafico$Status == "ALERTA (Sobrecarga)",
    "red",
    "darkblue"
  ),
  lwd = 2,
  main = "Análise de incidentes de hardware",
  xlab = "Minutos em operação",
  ylab = "Contagem de ocorrências"
)

# limite
abline(
  h = limite_alerta,
  col = "red",
  lty = "dashed",
  lwd = 2
)

legend(
  "topright",
  legend = c("Eventos normais", "Alertas", "Limite estatístico"),
  col = c("darkblue", "red", "red"),
  lty = c(1, 1, 2),
  lwd = 2
)
