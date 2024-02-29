# Aceves Díaz César Alejandro. 
# 29 de febrero 2024. 
# P1.5 - Árboles de decisión.

source("Lib.Preprocess.R") #Carga de librerías.
set.seed(2002) #Establecer la semilla. 
options(scipen = 999) #Mostrar decimales en números. 

df.Position <- read.csv(file ="Position_Salaries.csv",
                      header = T,
                      stringsAsFactors = T)


df.Position$Position <- NULL

#Exploración. 
summary(df.Position)

#modelo con rpart.
mdl.Dtree <- rpart(formula = Salary ~ Level, data = df.Position, minsplit = 5)

summary(mdl.Dtree)

rpart.plot(mdl.Dtree)


x <- seq(min(df.Position[,1]) - 1,
         max(df.Position[,1]), + 1,
          by = 0.1)
new.Data <- as.data.frame(x)
colnames(new.Data) <- "Level"

grafica <- ggplot() +
  theme_light() +
  ggtitle("Salario vs Nivel") +
  xlab("Puesto")
  ylab("Salario") 

grafica
  
grafica.datos <- grafica +
  geom_point(aes(x = df.Position$Level,
                 y = df.Position$Salary),
             colour = "tomato") +
  geom_line(aes(x = df.Position$Level,
                y = predict(mdl.Dtree, 
                            newdata = df.Position)),
            colour = "cadetblue1")

grafica.datos
