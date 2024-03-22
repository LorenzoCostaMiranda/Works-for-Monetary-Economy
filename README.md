# Short-report-monetary-economy

O short-report à seguir é um trabalho promovido pela matéria de economia monetária do curso de ciências econômicas da Universidade Federal do Tocantins (UFT).

# Documentação 

## Compilando o PDF



### Dependências

- [Pandoc](https://pandoc.org/installing.html)
- MikTex ou TeXLive

  - Windows: [miktex.org](https://miktex.org/)
  - Linux flavors: TeXLive

É necessário instalar (install.packages()) um conjunto de pacotes e puxar suas bibliotecas (library()) para realizar a compilação do PDF. Segue o nome deles:

- GetBCBData
- dplyr
- pandoc
- ggplot2
- tibble
- tidyr
- kableExtra
- flextable
- openxlsx

Todo o script está presente no arquivo `multiplicador.rmd`, e o PDF já formado está em `multiplicador.pdf`.

### Observação:

Em desejo de observação ou alteração do projeto, lembrar de mudar os caminhos presentes no cabeçalho do arquivo `rmd` para o do seu diretório do template em `tex` presente na própria pasta `template`, do `crossref` existente na pasta `filter` e do `header.tex` na pasta `header`.