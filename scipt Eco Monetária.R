install.packages("GetBCBData")
install.packages("flextable")
install.packages("sidrar")
install.packages("dplyr")
install.packages("tibble")
install.packages("tidyr")
library(GetBCBData)
library(sidrar)
library(dplyr)
library(tibble)
library(tidyr)
library(flextable)


TabelaResBan <- GetBCBData::gbcbd_get_series(
  id =  1787,
  first.date = "2003-01-01",
  last.date = "2023-12-01"
)

TabelaPMPP <- GetBCBData::gbcbd_get_series(
  id = 27789 ,
  first.date = "2003-01-01",
  last.date = "2023-12-01"
)


TabelaBASE <- GetBCBData::gbcbd_get_series(
  id =  1788,
  first.date = "2003-01-01",
  last.date = "2023-12-01"
)

TabelaDepAvi <- GetBCBData::gbcbd_get_series(
  id =  27790,
  first.date = "2003-01-01",
  last.date = "2023-12-01"
)

TabelaMP <- GetBCBData::gbcbd_get_series(
  id = 27791,
  first.date = "2003-01-01",
  last.date = "2023-12-01"
)


class(TabelaResBan$value)
class(TabelaDepAvi$value)
class(TabelaMP$value)
class(TabelaBASE$value)
class(TabelaPMPP$value)

dates <- seq.Date(from = as.Date("2003-01-01"), to = as.Date("2023-12-01"), by = "month")


vetormp <- TabelaMP[[2]]
vetordepavi <- TabelaDepAvi[[2]]
vetorresban <- TabelaResBan[[2]]
vetorPPMP <- TabelaPMPP[[2]]
vetorBASE <- TabelaBASE[[2]]

vetor_mp <- format(vetormp, big.mark = ".", decimal.mark = ",", scientific = FALSE)
vetor_depavi <- format(vetordepavi, big.mark = ".", decimal.mark = ",", scientific = FALSE)
vetor_resban <- format(vetorresban, big.mark = ".", decimal.mark = ",", scientific = FALSE)
vetor_PPMP <- format(vetorPPMP, big.mark = ".", decimal.mark = ",", scientific = FALSE)
vetor_BASE <- format(vetorBASE, big.mark = ".", decimal.mark = ",", scientific = FALSE)


#criação das séries temporais

Z <- function(s, t){
  Resultado = s - t
  return(Resultado)
}

Vetor_Encaixe <- mapply(Z, TabelaBASE[[2]], TabelaPMPP[[2]])

TabelaEncaixe <- tibble(Data = dates, Valor = Vetor_Encaixe)

TabelaBacen <- tibble(Data = dates, "Meios de Pagamentos" = vetor_mp, 
                      "Depositos a vista" = vetor_depavi, "Encaixes Tecnicos" = Vetor_Encaixe)

X <- function(x,y){
  Resultado = x/y
  return(Resultado)
}

Coeficiente_e <- mapply(X, TabelaEncaixe[[2]], TabelaDepAvi[[2]])

Coeficiente_d <- mapply(X, TabelaDepAvi[,2], TabelaMP[,2])


SerieTemporal_e <- tibble(data = dates, valor = Coeficiente_e)
SerieTemporal_d <- tibble(data = dates, valor = Coeficiente_d)

y <- function(d,e){
  Resultado = 1/(1-d * (1-e))
  return(Resultado)
}

Coeficientes <- tibble(data = dates, Valor_de_e = Coeficiente_e, Valor_de_d = Coeficiente_d)


Multiplicador_mon <- mapply(y, Coeficientes[,3], Coeficientes[,2])
SerieTemporal_alpha <- tibble(data = dates, valor = Multiplicador_mon)


vetor_e <- SerieTemporal_e[[2]]
vetor_d <- SerieTemporal_d[[2]]
vetor_multiplicador <- Multiplicador_mon


TabelaBacen <- TabelaBacen %>%
  add_column(e = vetor_e, d = vetor_d, alpha = vetor_multiplicador, .after = "Encaixes Tecnicos", .name_repair = "unique")




