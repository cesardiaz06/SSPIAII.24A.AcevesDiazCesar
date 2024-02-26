source("Lib.Preprocess.R") #Carga de librerías.
set.seed(2002) #Establecer la semilla. 
options(scipen = 999) #Mostrar decimales en números. 


#Datos. 
df.Social <- read.csv(file ="Social_Network_Ads.csv",
                      header = T,
                      stringsAsFactors = T)


#Eliminamos la columna de ID de usuario ya que no es relevante para el modelo.
df.Social$User.ID <- NULL
  
#Exploración. 
summary(df.Social)
boxplot(df.Social$Gender)
boxplot(df.Social$Age)
boxplot(df.Social$EstimatedSalary)
boxplot(df.Social$Purchased)

#oConvertir a numeros la columna de género para trabajar con los datos.
#2 <- Male, 1 <- Female. 
df.Social$Gender <- as.numeric(df.Social$Gender)


#Selección de variables.
cor.Social <- cor(df.Social)
corrplot(cor.Social,
         addCoef.col = "black",
         insig = "label_sig",
         method = "pie",
         type = "full",
         diag = F,
         col = viridis(n = 5, direction = 1),
         title = "Correlación Social Network Ads")

df.Social$Gender <- NULL

#Escalado de los datos
df.Social$Age <- scale(df.Social$Age)
df.Social$EstimatedSalary <- scale(df.Social$EstimatedSalary)

df.Social$Age <- as.numeric(df.Social$Age)
df.Social$EstimatedSalary <- as.numeric(df.Social$EstimatedSalary)

#División entrenamiento y prueba. 
Split <- sample.split(df.Social$Purchased, SplitRatio = 0.8)
df.Social.Train <- subset(df.Social, Split == T)
df.Social.Test <- subset(df.Social, Split == F)

#Creación del modelo.
mdl.RLog <- glm(formula = Purchased ~ .,
                data = df.Social.Train,
                family = binomial)

#Calculamos las probabilidades con base en el conjunto de datos de prueba. 
predict.Social <- predict(mdl.RLog, type = "response",
                          newdata = df.Social.Test)

Y.pred <- ifelse(predict.Social >= 0.5, 1, 0)
Y.pred


#Gráfica
plt.Social <- ggplot(data = df.Social.Train, aes(x = Age, y = Purchased)) +
  geom_point() +
  stat_smooth(method = "glm", method.args = list(family="binomial"), se = FALSE, colour= "blue") +
                xlab("Edad") +
                ylab("Probabilidad de compra")

plt.Social

ggsave(filename = "Grafica_sigmoide.jpg",
       plot = plt.Social,
       units = "in",
       height = 7, width = 14)


#Matriz de confusión.
matriz <- table(df.Social.Test$Purchased, Y.pred)
matriz
View(matriz)
confusionMatrix(matriz)$byClass

for1 <- confusionMatrix(as.factor(Y.pred), 
                        as.factor(df.Social.Test$Purchased), 
                        mode = "everything", 
                        positive = "1")

for1
#Formulas manuales. 

#Obteniendo los coeficientes.
TP = matriz[1,1]
FP = matriz[2,1]
FN = matriz[1,2]
TN = matriz[2,2]

#Accuracy. 
# A = (TP+TN)/(TP+TN+FP+FN)
A = (TP+TN)/(TP+TN+FP+FN)
A

#Precisión.
# P = (TP)/(TP+FP)
P = (TP)/(TP+FP)
P

#Recall
# R = (TP)/(TP+FN)
R = (TP)/(TP+FN)
R

#F1 Score. 
# F1 = (2 * P * R)/(P+R)
F1 = (2 * P * R)/(P+R)
F1
