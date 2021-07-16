## exploro alguna opciones
# 
# 1._ Selectividad

library(knitr) 
library(stringr)
library(reshape) 
library(dplyr) 
library(ggplot2)
library(ggthemes) 
library(patchwork) 
library(strucchange) 


raiz_dir <- "E:\\repos_2021\\ANCHZCS_0721\\CBA_test"
dir.Fig  <- "Figuras"
fig      <-c("pdf")

if (file.exists(file.path(raiz_dir, dir.Fig))){
  setwd(file.path(raiz_dir))
} else {
  dir.create(file.path(raiz_dir, dir.Fig))
  setwd(file.path(raiz_dir))
}

source('../funciones/functions.R')
source('../funciones/Fn_PBRs.R')
ant <-reptoRlist('../DatosEntrada.dat')


# Corro modelo con Self fija (similar a sardina) --------------------------

setwd("./codes_test/")
system("admb MAE0721b")
system("MAE0721b -nox -iprint 50")
setwd("../")

setwd("./codes_test/")
system("admb MAE0721b_nm")
system("MAE0721b_nm -nox -iprint 50")
setwd("../")



# Evaluo selectividades ---------------------------------------------------

A50f = 1.23646243114
log_rangof = -1.91212241596e-08
edades = c(0.5, 1.5, 2.5, 3.5, 4.5)

selec <- function(A50f,log_rangof,edades){
  tmp <- 1+exp(-1.0*log(19)*(edades-A50f)/exp(log_rangof))
  return(1/tmp)
}

opt1 <- selec(A50f,log_rangof,edades)

dA = -0.3
dR = 0
tst1 <- selec(A50f+dA,log_rangof+dR,edades)

dA = -0.3
dR = -0.3566749
tst2 <- selec(A50f+dA,log_rangof+dR,edades)

dA = -0.4
dR = 0
tst3 <- selec(A50f+dA,log_rangof+dR,edades)

dA = -1.01704   # similar a sardina 0.2194224
dR = -2.948748e-07   # similar a sardina -3.13996e-07
tst4 <- selec(A50f+dA,log_rangof+dR,edades)

sel.test <- bind_rows(tibble(age=edades,sel=opt1,modelo='base'),
                      tibble(age=edades,sel=tst1,modelo='tst1'),
                      tibble(age=edades,sel=tst2,modelo='tst2'),
                      tibble(age=edades,sel=tst3,modelo='tst3'),
                      tibble(age=edades,sel=tst4,modelo='tst4'))


sel.test %>% ggplot(aes(age,sel)) + 
  geom_point(aes(colour=modelo, fill=modelo), size=3) + 
  geom_line(aes(colour=modelo)) + 
  ggsci::scale_colour_startrek() + 
  egg::theme_article(base_size = 12) + 
  ggpubr::grids(linetype = "dashed") +
  theme(legend.position = "bottom") + 
  labs(x = 'Edad', y = 'Selectividad') +
  scale_x_continuous(breaks = seq(0.5, 4.5, by = 1))



# Comparo entre base y test -----------------------------------------------

data         <- lisread("codes_test/MAE0721b.dat") 
names(data)  <- str_trim(names(data), side="right")

rep.base     <- reptoRlist("../CBA_julio/MAE0721b.rep")
std.base     <- read.table("../CBA_julio/MAE0721b.std",header=T,sep="",na="NA",fill=T) 

rep.test     <- reptoRlist("codes_test/MAE0721b.rep")
std.test     <- read.table("codes_test/MAE0721b.std",header=T,sep="",na="NA",fill=T) 

# comparo variables de estado
resul <- bind_rows(tibble(year=1997:2021, value=rep.base$SSB, modelo='base', var='SSB'),
                   tibble(year=1997:2021, value=rep.test$SSB, modelo='test', var='SSB'),
                   tibble(year=1997:2021, value=rep.base$Reclutas, modelo='base', var='R'),
                   tibble(year=1997:2021, value=rep.test$Reclutas, modelo='test', var='R'),
                   tibble(year=1997:2021, value=rep.base$BT, modelo='base', var='BT'),
                   tibble(year=1997:2021, value=rep.test$BT, modelo='test', var='BT'),
                   tibble(year=1997:2021, value=rep.base$Ftot, modelo='base', var='FT'),
                   tibble(year=1997:2021, value=rep.test$Ftot, modelo='test', var='FT') )

resul %>% ggplot(aes(year,value)) + 
  geom_point(aes(colour=modelo, fill=modelo), size=3) + 
  geom_line(aes(colour=modelo)) + 
  facet_wrap(. ~ var, scales = 'free_y') + 
  ggsci::scale_colour_startrek() + 
  egg::theme_article(base_size = 12) + 
  ggpubr::grids(linetype = "dashed") +
  theme(legend.position = "bottom") + 
  labs(x = 'Edad', y = 'Value', title = 'Variables de Estado', caption = 'Compara selectividades parametricas v/s fija') 
ggsave('varestate.png', device = 'png', path = 'Figuras/', width = 20, height = 20, units = 'cm', dpi = 300)


# comparo ajustes de series de tiempo
resul <- bind_rows(tibble(year=1997:2021, obs=rep.base$pelacesobs, fit=rep.base$pelacespred, modelo='base', var='Pelaces'),
                   tibble(year=1997:2021, obs=rep.test$pelacesobs, fit=rep.test$pelacespred, modelo='test', var='Pelaces'),
                   tibble(year=1997:2021, obs=rep.base$reclasobs, fit=rep.base$reclaspred, modelo='base', var='Reclas'),
                   tibble(year=1997:2021, obs=rep.test$reclasobs, fit=rep.test$reclaspred, modelo='test', var='Reclas'),
                   tibble(year=1997:2021, obs=rep.base$desembarqueobs, fit=rep.base$desembarquepred, modelo='base', var='Desembarques'),
                   tibble(year=1997:2021, obs=rep.test$desembarqueobs, fit=rep.test$desembarquepred, modelo='test', var='Desembarques') )

resul %>% ggplot() + 
  geom_point(aes(x=year, y=obs), colour='lightskyblue4', size=3) + 
  geom_line(aes(x=year, y=fit, colour=modelo)) + 
  facet_wrap(. ~ var, scales = 'free_y') + 
  ggsci::scale_colour_startrek() + 
  egg::theme_article(base_size = 12) + 
  ggpubr::grids(linetype = "dashed") +
  theme(legend.position = "bottom") + 
  labs(x = 'Year', y = 'Biomasa / Captura', title = 'Ajustes del modelo', caption = 'Compara selectividades parametricas v/s fija') 
ggsave('fit_timesseries.png', device = 'png', path = 'Figuras/', width = 30, height = 20, units = 'cm', dpi = 300)


# comparo ajustes de abundancia por edad

resul <- bind_rows(as_tibble(rep.base$pobs_RECLAS) %>% mutate(modelo='base', src='Reclas', type='obs', year=1997:2021) %>% 
                     tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                   as_tibble(rep.base$ppred_RECLAS) %>% mutate(modelo='base', src='Reclas', type='fit', year=1997:2021) %>% 
                     tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                   as_tibble(rep.test$pobs_RECLAS) %>% mutate(modelo='test', src='Reclas', type='obs', year=1997:2021) %>% 
                     tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                   as_tibble(rep.test$ppred_RECLAS) %>% mutate(modelo='test', src='Reclas', type='fit', year=1997:2021) %>% 
                     tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value")) %>% mutate(age = factor(age))

 ggplot() + geom_bar(data=resul %>% filter(type=='obs' & modelo=='base'), aes(age,value), stat = 'identity') + 
   geom_line(data=resul %>% filter(type!='obs'), aes(x=age, y=value, color = modelo, group = modelo), size=0.9) +
   facet_wrap(. ~ year, dir = 'v') +
   ggsci::scale_colour_startrek() + 
   egg::theme_article(base_size = 14) + 
   ggpubr::grids(linetype = "dashed") +
   theme(legend.position = "bottom") + 
   labs(x = 'Age', y = 'Proporcion', title = 'Crucero Reclas', caption = 'Compara selectividades parametricas v/s fija') 
 ggsave('fit_ageReclas.png', device = 'png', path = 'Figuras/', width = 40, height = 45, units = 'cm', dpi = 300)
   


resul <- bind_rows(as_tibble(rep.base$pobs_PELACES) %>% mutate(modelo='base', src='Pelaces', type='obs', year=1997:2021) %>% 
                    tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                  as_tibble(rep.base$ppred_PELACES) %>% mutate(modelo='base', src='Pelaces', type='fit', year=1997:2021) %>% 
                    tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                  as_tibble(rep.test$pobs_PELACES) %>% mutate(modelo='test', src='Pelaces', type='obs', year=1997:2021) %>% 
                    tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                  as_tibble(rep.test$ppred_PELACES) %>% mutate(modelo='test', src='Pelaces', type='fit', year=1997:2021) %>% 
                    tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value")) %>% mutate(age = factor(age))
 
 ggplot() + geom_bar(data=resul %>% filter(type=='obs' & modelo=='base'), aes(age,value), stat = 'identity') + 
   geom_line(data=resul %>% filter(type!='obs'), aes(x=age, y=value, color = modelo, group = modelo), size=0.9) +
   facet_wrap(. ~ year, dir = 'v') +
   ggsci::scale_colour_startrek() + 
   egg::theme_article(base_size = 14) + 
   ggpubr::grids(linetype = "dashed") +
   theme(legend.position = "bottom") + 
   labs(x = 'Age', y = 'Proporcion', title = 'Crucero Pelaces', caption = 'Compara selectividades parametricas v/s fija') 
 ggsave('fit_agePelaces.png', device = 'png', path = 'Figuras/', width = 40, height = 45, units = 'cm', dpi = 300)


 resul <- bind_rows(as_tibble(rep.base$pobs_pel_tallas) %>% mutate(modelo='base', src='Pelaces', type='obs', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(37:40), names_to = "age", values_to = "value"),
                    as_tibble(rep.base$ppred_pel_tallas) %>% mutate(modelo='base', src='Pelaces', type='fit', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(37:40), names_to = "age", values_to = "value"),
                    as_tibble(rep.test$pobs_pel_tallas) %>% mutate(modelo='test', src='Pelaces', type='obs', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(37:40), names_to = "age", values_to = "value"),
                    as_tibble(rep.test$ppred_pel_tallas) %>% mutate(modelo='test', src='Pelaces', type='fit', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(37:40), names_to = "age", values_to = "value")) %>% mutate(age = factor(age))
 
 ggplot() + geom_bar(data=resul %>% filter(type=='obs' & modelo=='base'), aes(age,value), stat = 'identity') + 
   geom_line(data=resul %>% filter(type!='obs'), aes(x=age, y=value, color = modelo, group = modelo), size=0.9) +
   facet_wrap(. ~ year, dir = 'v') +
   ggsci::scale_colour_startrek() + 
   egg::theme_article(base_size = 14) + 
   ggpubr::grids(linetype = "dashed") +
   theme(legend.position = "bottom") + 
   labs(x = 'Age', y = 'Proporcion', title = 'Crucero Pelaces (tallas)', caption = 'Compara selectividades parametricas v/s fija') 
 #ggsave('fit_agePelaces.png', device = 'png', path = 'Figuras/', width = 40, height = 45, units = 'cm', dpi = 300)
 
 
 resul <- bind_rows(as_tibble(rep.base$pf_obs) %>% mutate(modelo='base', src='Pelaces', type='obs', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6:9), names_to = "age", values_to = "value"),
                    as_tibble(rep.base$pf_pred) %>% mutate(modelo='base', src='Pelaces', type='fit', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6:9), names_to = "age", values_to = "value"),
                    as_tibble(rep.test$pf_obs) %>% mutate(modelo='test', src='Pelaces', type='obs', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6:9), names_to = "age", values_to = "value"),
                    as_tibble(rep.test$pf_pred) %>% mutate(modelo='test', src='Pelaces', type='fit', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6:9), names_to = "age", values_to = "value")) %>% mutate(age = factor(age))
 
 ggplot() + geom_bar(data=resul %>% filter(type=='obs' & modelo=='base'), aes(age,value), stat = 'identity') + 
   geom_line(data=resul %>% filter(type!='obs'), aes(x=age, y=value, color = modelo, group = modelo), size=0.9) +
   facet_wrap(. ~ year, dir = 'v') +
   ggsci::scale_colour_startrek() + 
   egg::theme_article(base_size = 14) + 
   ggpubr::grids(linetype = "dashed") +
   theme(legend.position = "bottom") + 
   labs(x = 'Age', y = 'Proporcion', title = 'Flota', caption = 'Compara selectividades parametricas v/s fija') 
 ggsave('fit_ageFishery.png', device = 'png', path = 'Figuras/', width = 40, height = 45, units = 'cm', dpi = 300) 
 
 

# Comparo entre base y test 2 (tamano de muestra en pelaces 30) -----------

 rep.test2   <- reptoRlist("codes_test/MAE0721b_nm.rep")
 std.test2   <- read.table("codes_test/MAE0721b_nm.std",header=T,sep="",na="NA",fill=T)  
 
 
 resul <- bind_rows(as_tibble(rep.base$pobs_PELACES) %>% mutate(modelo='base', src='Pelaces', type='obs', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                    as_tibble(rep.base$ppred_PELACES) %>% mutate(modelo='base', src='Pelaces', type='fit', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                    as_tibble(rep.test2$pobs_PELACES) %>% mutate(modelo='test', src='Pelaces', type='obs', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value"),
                    as_tibble(rep.test2$ppred_PELACES) %>% mutate(modelo='test', src='Pelaces', type='fit', year=1997:2021) %>% 
                      tidyr::pivot_longer(!c(6,7,8,9), names_to = "age", values_to = "value")) %>% mutate(age = factor(age))
 
 ggplot() + geom_bar(data=resul %>% filter(type=='obs' & modelo=='base'), aes(age,value), stat = 'identity') + 
   geom_line(data=resul %>% filter(type!='obs'), aes(x=age, y=value, color = modelo, group = modelo), size=0.9) +
   facet_wrap(. ~ year, dir = 'v') +
   ggsci::scale_colour_startrek() + 
   egg::theme_article(base_size = 14) + 
   ggpubr::grids(linetype = "dashed") +
   theme(legend.position = "bottom") + 
   labs(x = 'Age', y = 'Proporcion', title = 'Crucero Pelaces', caption = 'Compara selectividades parametricas v/s fija') 
 ggsave('fit_agePelaces.png', device = 'png', path = 'Figuras/', width = 40, height = 45, units = 'cm', dpi = 300)
 
 
 sel.test <- bind_rows(tibble(age=edades, sel=rep.base$S_f[1,], modelo='base', src='Pesqueria'),
                       tibble(age=edades, sel=rep.test$S_f[1,], modelo='test1', src='Pesqueria'),
                       tibble(age=edades, sel=rep.test2$S_f[1,], modelo='test2', src='Pesqueria'),
                       tibble(age=edades, sel=rep.base$Scru_reclas[1,], modelo='base', src='Reclas'),
                       tibble(age=edades, sel=rep.test$Scru_reclas[1,], modelo='test1', src='Reclas'),
                       tibble(age=edades, sel=rep.test2$Scru_reclas[1,], modelo='test2', src='Reclas'),
                       tibble(age=edades, sel=rep.base$Scru_pelaces[1,], modelo='base', src='Pelaces'),
                       tibble(age=edades, sel=rep.test$Scru_pelaces[1,], modelo='test1', src='Pelaces'),
                       tibble(age=edades, sel=rep.test2$Scru_pelaces[1,], modelo='test2', src='Pelaces'))
 
 
 sel.test %>% ggplot(aes(age,sel)) + 
   geom_point(aes(colour=modelo, fill=modelo), size=3) + 
   geom_line(aes(colour=modelo)) + 
   facet_wrap(. ~ src, dir = 'h') +
   ggsci::scale_colour_startrek() + 
   egg::theme_article(base_size = 12) + 
   ggpubr::grids(linetype = "dashed") +
   theme(legend.position = "bottom") + 
   labs(x = 'Edad', y = 'Selectividad') +
   scale_x_continuous(breaks = seq(0.5, 4.5, by = 1))
 
 
 
 
 