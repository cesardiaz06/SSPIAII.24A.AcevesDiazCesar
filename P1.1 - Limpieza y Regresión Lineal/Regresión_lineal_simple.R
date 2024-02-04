# Alumno: Aceves Díaz César Alejandro.
# Código: 217589504. 
# Actividad: P1.1 - Limpieza y regresión lineal. 
# Fecha: 03 de febrero del 2024. 

source("Preprocess.R") #Llamamos el archivo que contiene el dataset y su preprocesado. 

#Modelo Reg. Lineal, dónde mpg es millas por galón y wt peso del vehículo.
mdl.Regresor <- lm(formula = mpg ~ wt,
                   data = df.mtcars.Train)

#Predicción
mdl.Predict <- predict(object = mdl.Regresor,
                       newdata = df.mtcars.Test)

summary(mdl.Regresor)

#Creación de la gráfica base. 
plt.mpg <- ggplot() + 
  theme_light() +
  ggtitle("Regresión: Millas por galón segun el Peso del vehículo") +
  xlab("Peso del vehículo") +
  ylab("Millas por galón")


#Gráfica del modelo y regresión lineal. 
plt.mtcars.Data <- plt.mpg + 
  geom_point(aes(x = df.mtcars.Train$wt,
                 y = df.mtcars.Train$mpg),
             colour = "aquamarine3") +
  geom_line(aes(x = df.mtcars$wt,
                y = predict(mdl.Regresor,
                            newdata = df.mtcars)),
            colour = "cadetblue1")



