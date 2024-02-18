#Librerías.
list.of.packages <- c("ggplot2","caTools","mltools","data.table","cowplot","e1071","MASS")

#Librerías.
list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

#Valida que librerías no esán instalas y procede a instalarlas. 
if(length(new.packages)) install.packages(new.packages)

#Aplicar o activar todas las librerías de nuestro vector principal. 
lapply(list.of.packages, require, character.only = T)

#establecer semilla. 
set.seed(2002)

#mostrar los números con decimales. 
options(scipen = 999)
  
