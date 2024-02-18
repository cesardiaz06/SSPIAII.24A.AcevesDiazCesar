# Aceves Díaz César Alejandro. 
# 217589504
# P1.3 Polinomial Vs SVR. 


source("Lib.Preprocess.R")

#Preprocesamiento. 
df.Startups <- read.csv("50_Startups.csv",
                        header = T, 
                        stringsAsFactors = T)

df.Startups$State <- NULL

#Exploración. 
summary(df.Startups)
boxplot(df.Startups$R.D.Spend)
boxplot(df.Startups$Administration)
boxplot(df.Startups$Marketing.Spend)
boxplot(df.Startups$Profit)


#Selección de variables. 
mt.Correlation <- cor(df.Startups)
View(mt.Correlation)

install.packages("corrplot")
install.packages("viridis")
library(corrplot)
library(viridis)

corrplot(mt.Correlation,
         addCoef.col = "black",
         insig = "label_sig",
         method = "circle",
         type = "full",
         diag = F,
         col = viridis(n = 5, direction = 1),
         title = "Correlación Startups")


#Modelo
Split <- sample.split(df.Startups$Profit,
                      SplitRatio = 0.8)
df.Startups.Train <- subset(df.Startups, Split == T)
df.Startups.Test <- subset(df.Startups, Split == F)

#Modelo lineal. 
mdl.g1.Startups <- lm(formula = Profit ~ R.D.Spend, data = df.Startups.Train)
summary(mdl.g1.Startups)

plt.Startups.g1 <- geom_line(aes(x = df.Startups.Train$R.D.Spend,
                                 y = predict(mdl.g1.Startups,
                                             newdata = df.Startups.Train)),
                             colour ="firebrick") 

#Modelo de grado 2. 
mdl.g2.Startups <- lm(formula = Profit ~ poly(R.D.Spend,2), 
                      data = df.Startups.Train)
summary(mdl.g2.Startups)

plt.Startups.g2 <- geom_line(aes(x = df.Startups.Train$R.D.Spend,
                                 y = predict(mdl.g2.Startups,
                                             newdata = df.Startups.Train)),
                             colour ="gold4") 

#Modelo de grado 3. 
mdl.g3.Startups <- lm(formula = Profit ~ poly(R.D.Spend,3), 
                      data = df.Startups.Train)
summary(mdl.g3.Startups)

plt.Startups.g3 <- geom_line(aes(x = df.Startups.Train$R.D.Spend,
                                 y = predict(mdl.g3.Startups,
                                             newdata = df.Startups.Train)),
                             colour ="deeppink2") 

#Modelo de grado 4. 
mdl.g4.Startups <- lm(formula = Profit ~ poly(R.D.Spend,4), 
                      data = df.Startups.Train)
summary(mdl.g4.Startups)

plt.Startups.g4 <- geom_line(aes(x = df.Startups.Train$R.D.Spend,
                                 y = predict(mdl.g4.Startups,
                                             newdata = df.Startups.Train)),
                             colour ="sandybrown") 

#Modelo de grado 5. 
mdl.g5.Startups <- lm(formula = Profit ~ poly(R.D.Spend,5), 
                      data = df.Startups.Train)
summary(mdl.g5.Startups)

plt.Startups.g5 <- geom_line(aes(x = df.Startups.Train$R.D.Spend,
                                 y = predict(mdl.g4.Startups,
                                             newdata = df.Startups.Train)),
                             colour ="royalblue4") 

#Gráfico
plt.Startups <- ggplot() +
  geom_point(aes(x = df.Startups.Train$R.D.Spend,
                 y = df.Startups.Train$Profit), 
             colour = "darkslateblue")+
  geom_point(aes(x = df.Startups.Test$R.D.Spend,
                 y = df.Startups.Test$Profit), 
             colour = "yellow")+
  xlab("Gastos de investigación y desarrollo")+
  ylab("Ganancia")
  
plt.Startups

plt.g1 <- plt.Startups + plt.Startups.g1 + ggtitle("Gráfico: grado 1.")
plt.g2 <- plt.Startups + plt.Startups.g2 + ggtitle("Gráfico: grado 2.")
plt.g3 <- plt.Startups + plt.Startups.g3 + ggtitle("Gráfico: grado 3.")
plt.g4 <- plt.Startups + plt.Startups.g4 + ggtitle("Gráfico: grado 4.")
plt.g5 <- plt.Startups + plt.Startups.g5 + ggtitle("Gráfico: grado 5.")

plt.grid <- plot_grid(plt.g1,plt.g2,plt.g3,plt.g4,plt.g5, ncol = 2)
plt.grid

ggsave(filename = "Graficas_Modelos.jpg",
       plot = plt.grid,
       units = "in",
       height = 7, width = 14)

#Almacena los objetos a continuación para poder crear el gráfico en Rmarkdown.
save(plt.grid, plt.g2,
     file = "Grafica")




