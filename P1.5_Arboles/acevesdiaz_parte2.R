# Aceves Díaz César Alejandro. 
# 29 de febrero 2024. 
# P1.5 - Árboles de decisión.

source("Lib.Preprocess.R") #Carga de librerías.
set.seed(2002) #Establecer la semilla. 
options(scipen = 999) #Mostrar decimales en números. 

df.Social <- read.csv(file = "Social_Network_Ads.csv",
                      header = T, 
                      stringsAsFactors = T)

#Eliminamos la columna de ID de usuario ya que no es relevante para el modelo.
df.Social$User.ID <- NULL
df.Social$Gender <- NULL
summary(df.Social)

#Convertimos la variable objetivo a factor para un mejor manejo.
df.Social$Purchased <- as.factor(df.Social$Purchased)

#División entrenamiento y prueba. 
Split <- sample.split(df.Social$Purchased, SplitRatio = 0.8)
df.Social.Train <- subset(df.Social, Split == T)
df.Social.Test <- subset(df.Social, Split == F)


#Modelo 1 con rpart. 
mdl.rpart <- rpart(formula = Purchased ~ Age, data = df.Social.Train, minsplit = 30)
plot.rpart.model <- rpart.plot(mdl.rpart)

#Modelo 2 con randomForest.
mdl.randomForest <- randomForest(formula = Purchased ~ Age, 
                                 data = df.Social.Train, 
                                 ntree = 500,
                                 keep.forest = TRUE,
                                 minsplit = 30)


predict.Social.rpart <- predict(mdl.rpart, type = "prob",
                          newdata = df.Social.Train) 
Y.pred <- 
predict.Social <- predict(mdl.randomForest, type = "response",
                          newdata = df.Social.Train)

matriz.rF<- table(df.Social.Train$Purchased, predict.Social)
matriz


#Evaluación del modelo randomForest.
#Obteniendo los coeficientes.
TP = matriz.rF[1,1]
FP = matriz.rF[2,1]
FN = matriz.rF[1,2]
TN = matriz.rF[2,2]

#Accuracy. 
# A = (TP+TN)/(TP+TN+FP+FN) = 0.84375
A = (TP+TN)/(TP+TN+FP+FN)
A


#Precisión.
# P = (TP)/(TP+FP) = 0.8362069
P = (TP)/(TP+FP)
P

#Recall
# R = (TP)/(TP+FN) = 0.9417476
R = (TP)/(TP+FN)
R

#F1 Score. 
# F1 = (2 * P * R)/(P+R) = 0.8858447
F1 = (2 * P * R)/(P+R)
F1

