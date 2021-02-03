library(readxl)
library(metafor)
library(grid)
library(meta)
dat <- read_xlsx("LP.xlsx")
dat
dat.frame_2 <- data.frame(dat)

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
       xlim = c(-70,70),
       xlab="Standarized Mean Difference (95% CI)",
       mlab="RE Model for All Studies",
       subgroup = TRUE,
       print.byvar = FALSE,
       )
dev.off()
