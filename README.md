<h1 align="center"> Forest Plot in R — Meta analysis<img src="https://rstudio.com/wp-content/uploads/2018/10/RStudio-Logo-Flat.png" align="right" height="40px">
</h1>

[![Meta Rstudio](https://img.shields.io/endpoint?url=https%3A%2F%2Frstudio.github.io%2Frstudio-shields%2Fcategory%2Fmeta.json)](https://community.rstudio.com/c/meta)
<p align="center">Forest Plot - Meta analysis with subgroups the "meta" package in R</p>
* Librarys:

```R
library(readxl)
library(grid)
library(meta)
```

* Exemple table:

```R

dat <- read_xlsx("LP.xlsx")
View(dat)
```

<center>
  
| study    | Measure | nd | meand  | sdd  | n  | mean   | sd    |
|----------|---------|----|--------|------|----|--------|-------|
| Study 1  | CT      | 6  | 129,46 | 5,14 | 6  | 144,79 | 11,25 |
| Study 2  | CT      | 6  | 98,42  | 3,28 | 6  | 134,83 | 1,96  |
| Study 3  | CT      | 10 | 54,3   | 2,8  | 10 | 56,1   | 2,6   |
| Study 4  | CT      | 6  | 90,5   | 1,87 | 6  | 130,5  | 3,02  |
| Study 5  | CT      | 8  | 72,7   | 7,4  | 8  | 103    | 5,5   |
| Study 6  | CT      | 6  | 90,3   | 2,72 | 6  | 106,8  | 3,09  |
| Study 7  | CT      | 6  | 92,3   | 2,71 | 6  | 106,5  | 3,05  |
| Study 8  | TG      | 6  | 127,82 | 6,93 | 6  | 269,3  | 13,59 |
| Study 9  | TG      | 6  | 110,22 | 2,48 | 6  | 25,67  | 1,16  |
| Study 10 | TG      | 10 | 60,6   | 7,5  | 10 | 85,5   | 13,3  |
| Study 11 | TG      | 6  | 93,33  | 1,51 | 6  | 153    | 3,35  |
| Study 12 | TG      | 6  | 88,5   | 3,23 | 6  | 105,1  | 2,8   |
| Study 13 | TG      | 6  | 88,5   | 3,23 | 6  | 75,41  | 3,15  |
| Study 14 | HDL     | 6  | 34,64  | 2,39 | 6  | 22,69  | 2,58  |
| Study 15 | HDL     | 6  | 42,46  | 2,98 | 6  | 25,67  | 1,16  |
| Study 16 | HDL     | 6  | 31,37  | 0,82 | 6  | 25,16  | 0,98  |

</center>

<img src="" width="600px"/>


<br>
* See code:

```R

dat <- read_xlsx("LP.xlsx")
dat
dat.frame_2 <- data.frame(dat)

meta_2 <- metacont(dat$n,
                   dat$meand,
                   dat$sdd, # Experimental SD
                   dat$nd, # N for  Control grup
                   dat$mean,
                   dat$sd,
                   as.character(dat$frame), 
                   #o ultimo import será de valor chr que levará os dados dos autores
                   data = dat.frame_2, #aponta para de onde virá os dados da análise
                   byvar = Measure, 
                   #declara qual os subgrupos que vai usar,
                   #no caso os que foram inseridos na tablea na coluna "Measure".
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
       comb.random=FALSE, # Não plota o random efect
       xlim = c(-10,10), #escala do eixo X
       xlab="Standarized Mean Difference (95% CI)",
       mlab="RE Model for All Studies",
       subgroup = TRUE,
       print.byvar = FALSE,
)
dev.off()

```
