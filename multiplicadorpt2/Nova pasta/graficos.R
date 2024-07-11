


install.packages("plotly", dependencies = TRUE)



library(zoo)
library(plotly)
library(htmltools)
library(GetBCBData)
library(dplyr)
library(pandoc)
library(ggplot2)
library(tibble)
library(tidyr)
library(kableExtra)
library(flextable)
library(openxlsx)
library(scales)
library(reshape2)
library(patchwork)
library(corrplot)


#Gráficos para a Análise Geral

Tab <- read.xlsx("C:/Users/Lorenzo Costa/Desktop/Trabalhos/Trabalhos Economia Monetaria/multiplicadorpt2/Nova pasta/TabelaGeral.xlsx")


ipca12meses <- seq(12, nrow(TabelaIPCA), by = 12)
df_intervalo12ipca <- TabelaIPCA[ipca12meses, ]


#M1M2 e M3M4 PIB

p90 <- plot_ly() %>%
  add_lines(data = Tab, x = ~Tab$data, y = ~M1M2, name = "M1+M2/PIB", color = I("green")) %>%
  add_lines(data = Tab, x = ~Tab$data, y = ~M3M4, name = "M3+M4/PIB", color = I('orange'),
            yaxis = "y2")

p90 <- p90 %>%
  layout(
    title = "Proporção dos agregados de liquidez pelo PIB",
    yaxis = list(title = "M1+M2/PIB"),
    yaxis2 = list(
      title = "M3+M4/PIB",
      overlaying = "y",
      side = "right"
    )
  )

p90




#M1M2 e IPCA acumulado


p99 <- plot_ly() %>%
  add_lines(data = Tab, x = ~Tab$data, y = ~M1M2, name = "M1+M2/PIB", color = I("green")) %>%
  add_lines(data = df_intervalo12ipca, x = ~Tab$data, y = ~value, name = "IPCA Acumulado", color = I('purple'),
            yaxis = "y2")

p99 <- p99 %>%
  layout(
    title = "Proporção dos agregados de maior liquidez em relação ao IPCA",
    yaxis = list(title = "M1+M2/PIB"),
    yaxis2 = list(
      title = "IPCA Acumulado",
      overlaying = "y",
      side = "right"
    )
  )

p99


#M1M2 e IPCA média

p70 <- plot_ly() %>%
  add_lines(data = Tab, x = ~Tab$data, y = ~M1M2, name = "M1+M2/PIB", color = I("green")) %>%
  add_lines(data = IPCAdf, x = ~Tab$data, y = ~ipca, name = "IPCA média anual", color = I('purple'),
            yaxis = "y2")

p70 <- p70 %>%
  layout(
    title = "Proporção dos agregados de maior liquidez em relação ao IPCA",
    yaxis = list(title = "M1+M2/PIB"),
    yaxis2 = list(
      title = "IPCA média ",
      overlaying = "y",
      side = "right"
    )
  )

p70


#M1M2 e SELIC




#M3M4 e SELIC

p80 <- plot_ly() %>%
  add_lines(data = Tab, x = ~Tab$data, y = ~M3M4, name = "M3+M4/PIB", color = I("orange")) %>%
  add_lines(data = SelicDf, x = ~Tab$data, y = ~selic, name = "Média Selic Anual", color = I('blue'),
            yaxis = "y2")

p80 <- p80 %>%
  layout(
    title = "Proporção dos agregados de menor liquidez em relação à SELIC",
    yaxis = list(title = "M3+M4/PIB"),
    yaxis2 = list(
      title = "Média Selic",
      overlaying = "y",
      side = "right"
    )
  )

p80


### Gráficos Para a Análise Específica

TabG <- read.xlsx("C:/Users/Lorenzo Costa/Desktop/Trabalhos/Trabalhos Economia Monetaria/multiplicadorpt2/Nova pasta/TabelaG.xlsx")

class(TabG$Data)

TabG$data <- as.numeric(TabG$data)




# M1 + M2 / M3 + M4 com o PIB


p1 <- plot_ly(data = TabG, x = ~Data) %>%
  add_lines(y = ~percentDIV, name = "Variação M1+M2/M3+M4", color = I("red")) %>%
  add_lines(y = ~percentPIB, name = "Variação PIB", color = I('purple'),
            yaxis = "y2") %>%
  layout(
    title = "Comparação da variação da proporção agregados de maior sobre o de menor liquidez com o PIB",
    yaxis = list(title = "M1+M2/M3+M4(%)"),
    yaxis2 = list(
      title = "PIB(%)",
      overlaying = "y",
      side = "right"
    )
  )
p1

# M1 + M2 / M3 + M4 com a SELIC

bimSELIC <- read.xlsx("C:/Users/Lorenzo Costa/Desktop/Trabalhos/Trabalhos Economia Monetaria/multiplicadorpt2/Nova pasta/bimSELIC.xlsx")
bimIPCa <- read.xlsx("C:/Users/Lorenzo Costa/Desktop/Trabalhos/Trabalhos Economia Monetaria/multiplicadorpt2/Nova pasta/bimIPCA.xlsx")

view(bimSELIC)


TabG$percentSELIC <- bimSELIC$percetSELIC

TabG$percentIPCA <- bimIPCa$percetIPCA
view(TabG)

p2 <- plot_ly(data = TabG, x = ~Data) %>%
  add_lines(y = ~percentDIV, name = "Variação M1+M2/M3+M4", color = I("red")) %>%
  add_lines(y = ~percentSELIC, name = "Variação SELIC", color = I('blue'),
            yaxis = "y2") %>%
  layout(
    title = "Comparação da variação dos agregados de menor liquidez com a SELIC em 2005",
    yaxis = list(title = "M1+M2/M3+M4(%)"),
    yaxis2 = list(
      title = "Selic(%)",
      overlaying = "y",
      side = "right"
    )
  )
p2

#M1 + M2 / M3 + M4 com o IPCA

p3 <- plot_ly(data = TabG, x = ~Data) %>%
  add_lines(y = ~percentDIV, name = "Variação M1+M2/M3+M4", color = I("red")) %>%
  add_lines(y = ~percentIPCA, name = "Variação IPCA", color = I('pink'),
            yaxis = "y2") %>%
  layout(
    title = "Comparação da variação dos agregados de menor liquidez com o IPCA em 2005",
    yaxis = list(title = "M1+M2/M3+M4(%)"),
    yaxis2 = list(
      title = "IPCA(%)",
      overlaying = "y",
      side = "right"
    )
  )
p3
