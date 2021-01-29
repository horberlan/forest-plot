# Forest Plot in R [![Meta Rstudio](https://img.shields.io/endpoint?url=https%3A%2F%2Frstudio.github.io%2Frstudio-shields%2Fcategory%2Fmeta.json)](https://community.rstudio.com/c/meta)
<p align="center">Forest Plot - Meta analysis with subgroups the "meta" package in R</p>

* Exemple:
<!--<img src="https://raw.githubusercontent.com/horberlan/forest-plot/main/LP%20-%20Forestplot.png?token=ALEU6A2BWTNETMS4G4NL5LLACRW2C" width="600px"/> -->

* Librarys:
```Monokai
library(readxl) #
library(grid) #
library(meta) #
```
<br>
* See code:

```R

dat <- read_xlsx("LP.xlsx")
dat
dat.frame_2 <- data.frame(dat
                          )#

meta_2 <- metacont(dat$n,
                   dat$meand,
                   dat$sdd,
                   dat$nd,
                   dat$mean,
                   dat$sd,
                   as.character(dat$frame), #o ultimo import será de valor chr que levará os dados dos autores 
                   data = dat.frame_2, #aponta para de onde virá os dados da análise
                   byvar = Measure, #declara qual os subgrupos que vai usar, no caso os que foram inseridos na tablea na coluna "Measure".
                   comb.fixed = TRUE,#para que on números não fiquem randomicos.
                   sm="SMD" #medida de sumáio usada para agrupar os dados.
                   )

#RE.res <- rma(n,meand,sdd,mean,sd, data=dat.frame_2, slab=paste(Measure))
#RE.res
png(file = 'LP - Forestplot.png',
    width=780,
    height=620)

forest(meta_2,
       order=order(dat$study), #ordena a coluna study
       leftlabs = c("Lipid Profile 
                    Author", "Total","Mean","SD","Total","Mean","SD"),
       comb.random=FALSE, #impede que os dados se mistures entre os subgrupos
       xlim = c(-10,10), #escala do eixo X
       xlab="Standarized Mean Difference (95% CI)",
       mlab="RE Model for All Studies",
       subgroup = TRUE,
       print.byvar = FALSE,
)
dev.off()

```
