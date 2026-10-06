Simulação de Alertas de Hardware em R

Este script em R faz parte de um projeto acadêmico voltado ao monitoramento contínuo de componentes de hardware de servidores utilizados em ambientes de computação em nuvem por plataformas de e-commerce.

No projeto, os dados de monitoramento são obtidos por meio da biblioteca psutil, em Python. Para esta etapa, o R é utilizado para simular um histórico de ocorrências de hardware e testar uma lógica estatística de geração de alertas.

A ideia é utilizar uma taxa média de eventos observada nos dados coletados para gerar uma simulação mensal e identificar períodos que apresentem uma quantidade de ocorrências acima do comportamento esperado.

🎯 Objetivo do script

O script tem como principais objetivos:

utilizar dados de referência obtidos pelo monitoramento com psutil;

calcular a taxa média de ocorrência de eventos;

simular eventos ao longo de um mês;

aplicar a distribuição de Poisson à simulação;

estabelecer um limite estatístico para alertas;

calcular a quantidade e o percentual de alertas;

gerar um gráfico para visualizar os eventos simulados.



A média dos dados é calculada utilizando:

lambda_estimado <- mean(dados_reais_psutil)


O valor obtido é utilizado como parâmetro λ da distribuição de Poisson.

Para os dados utilizados no exemplo:

λ = 3,8 eventos por minuto


Ou seja, a simulação considera uma ocorrência média de aproximadamente 3,8 eventos por minuto.

A partir da taxa média estimada, são simulados eventos utilizando a função rpois():

simulacao_mensal <- rpois(
  n = minutos_no_mes,
  lambda = lambda_estimado
)


A função rpois() gera valores aleatórios seguindo uma distribuição de Poisson, utilizando λ como taxa média de ocorrência.
Dessa forma, o script cria uma representação simulada de como os eventos poderiam se distribuir ao longo de um mês de monitoramento.

📉  Visualização

Para facilitar a visualização dos resultados, são selecionados os primeiros 300 minutos:

amostra_grafico <- historico_hardware[1:300, ]

Em seguida, os eventos são apresentados em um gráfico:

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

No gráfico:

🔵 Azul representa eventos dentro do comportamento esperado;

🔴 Vermelho representa eventos classificados como alerta;

📏 Linha vermelha tracejada representa o limite estatístico.

O limite é inserido no gráfico através de:

abline(
  h = limite_alerta,
  col = "red",
  lty = "dashed",
  lwd = 2
)

⚠️ Observação

A simulação não representa necessariamente falhas reais de hardware. O objetivo do script é testar uma abordagem estatística para identificação de ocorrências fora do padrão, utilizando como referência a taxa média observada nos dados de monitoramento.

Em uma aplicação real, os valores utilizados na simulação poderiam ser substituídos por dados coletados continuamente pelo psutil, permitindo que a análise fosse realizada sobre o comportamento real dos servidores.
