# Alumno: Aceves Díaz César Alejandro. 
# Actividad: P1.7 - K-means
# Fecha: 16 de marzo del 2024. 
# Materia: Seminario de Solución de Problemas de Inteligencia Artificial II. 


#Importamos librerías necesarias, establecemos la semilla y establecemos mostrar números con decimal. 
source("Lib.Preprocess.R")
set.seed(2002)
options(scipen = 999)

#Importamos el dataset.
df.Kaggle <- read.csv(file ="Credit Card_Kaggle.csv",
                      header = T,
                      stringsAsFactors = T)


df.Kaggle$CUST_ID <- NULL

summary(df.Kaggle)

#Algunos boxplot para identificar valores atípicos (todos tienen datos atípicos).
boxplot(df.Kaggle$BALANCE)
boxplot(df.Kaggle$BALANCE_FREQUENCY)
boxplot(df.Kaggle$PURCHASES)
boxplot(df.Kaggle$ONEOFF_PURCHASES)
boxplot(df.Kaggle$INSTALLMENTS_PURCHASES)
boxplot(df.Kaggle$CASH_ADVANCE)


#Matriz de correlación.
cor.Kaggle <- cor(df.Kaggle)

#Crear un nuevo data frame con los datos a utilizar. 
df.Kaggle.nuevo <- df.Kaggle[, c("ONEOFF_PURCHASES", "PURCHASES_INSTALLMENTS_FREQUENCY", "CASH_ADVANCE_TRX")]

#Elbow - Saber cuantos clusters vamos a dejar.
n.obs <- length(df.Kaggle.nuevo$ONEOFF_PURCHASES)
WCSS <-  vector()
for (i in 1:20) {
  WCSS [i] <- kmeans(df.Kaggle.nuevo, i)$tot.withinss
  
}

WCSS <- as.data.frame(WCSS)
WCSS$k <- seq(1,20,1)


#Gráfica del método de codo.
ggplot() +
  geom_line(aes(x = WCSS$k,
                y = WCSS$WCSS)) +
  geom_point(aes(x = WCSS$k,
                 y = WCSS $WCSS,
                 color=WCSS$k)) +
  ggtitle("Método del codo") +
  xlab("Iteración") +
  ylab("WCSS")+
  theme_classic()


