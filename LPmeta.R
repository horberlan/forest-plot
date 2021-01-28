library(readxl)
library(metafor)
library(grid)
library(meta)
dat <- read_xlsx("LP.xlsx")
dat
dat.frame_2 <- data.frame(dat
                          )
dat.frame
meta_2 <- metacont(dat$n,
                   dat$meand,
                   dat$sdd,
                   dat$nd,
                   dat$mean,
                   dat$sd,
                   dat$study,
                   data = dat.frame_2,
                   byvar = Measure,
                   comb.fixed = TRUE,
                   sm="SMD"
                   )

#RE.res <- rma(n,meand,sdd,mean,sd, data=dat.frame_2, slab=paste(Measure))
#RE.res
png(file = 'LP - Forestplot.png',
    width=800,
    height=800)

forest(meta_2,
       order=order(dat$study),
       leftlabs = c("Lipid Profile 
                    Author", "Total","Mean","SD","Total","Mean","SD"),
       comb.random=FALSE,
       rows=c(1:3, 4:8, 8:10, 11:15, 16:19, 20:23),
       xlim = c(-10,10),
       xlab="Standarized Mean Difference (95% CI)",
       mlab="RE Model for All Studies",
       subgroup = TRUE,
       print.byvar = FALSE,
)
grid::grid.text("Lipid Profile", 0.5, 0.85, gp = grid::gpar(cex = 1.5))
dev.off()