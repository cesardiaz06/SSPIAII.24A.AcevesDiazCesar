# Alumno: Aceves Díaz César Alejandro.
# Código: 217589504. 
# Actividad: P1.1 - Limpieza y regresión lineal. 
# Fecha: 03 de febrero del 2024. 

#Importamos el archivo:
source("Lib.Preprocess.R") #Llamar las librerías de nuestro archivo externo. 
options(scipen = 999) #Hacer que muestre más decimales en el valor. 
set.seed(2002)#Semilla para el random.

# Crear un dataset con un conjunto de datos de la biblioteca de R. 
df.mtcars <- data.frame(mtcars)
df.mtcars <- df.mtcars[ ,c(1,6)]

#Preprocesamiento. 
summ.mtcars <- summary(df.mtcars) #Calculo de datos de tendencia central. 
bxp.mtcars <- boxplot(df.mtcars) #Diagrama de caja para determinar si existen datos atípicos. 

#Creación del dataset de entrenamiento y prueba para el modelo de regresión lineal. 
Split <- sample.split(Y = df.mtcars$mpg, SplitRatio = 0.8)
df.mtcars.Train <- subset(df.mtcars, Split == T)
df.mtcars.Test <- subset(df.mtcars, Split == F)




