library(readxl)
library(metafor)
library(grid)
library(meta)
dat <- read_xlsx("LP.xlsx")
dat
dat.frame_2 <- data.frame(dat
                          )#Precisa criar um "data.frema" para converter os valoes chr presentes nos dados numéricos pra num ou int, removendo então as vírguas.

meta_2 <- metacont(dat$n,
                   dat$meand,
                   dat$sdd,
                   dat$nd,
                   dat$mean,
                   dat$sd,
                   dat$study, #o ultimo import será de valor chr que levará os dados dos autores 
                   data = dat.frame_2, #aponta para de onde virá os dados da análise
                   byvar = Measure, #declara qual os subgrupos que vai usar, no caso os que foram inseridos na tablea na coluna "Measure".
                   comb.fixed = TRUE,#para que on números não fiquem randomicos.
                   sm="SMD" #medida de sumáio usada para agrupar os dados.
                   )

#RE.res <- rma(n,meand,sdd,mean,sd, data=dat.frame_2, slab=paste(Measure))
#RE.res
png(file = 'LP - Forestplot.png',
    width=800,
    height=800)

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
grid::grid.text("Lipid Profile", 0.5, 0.85, gp = grid::gpar(cex = 1.5))
dev.off()
