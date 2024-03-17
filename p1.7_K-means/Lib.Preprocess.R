#Librerías.
libs <- c("ggplot","caTools","mltools","data.table","cowplot","e1071","caret","randomForest","rpart","lattice")

#Librerías.
if(!require(ggplot2))
{install.packages(libs, dependences = T)}

if(!require(caret))
{install.packages(libs, dependences = T)}

#Habilitarlas.
library(ggplot2)
library(caTools)
library(mltools)
library(data.table)
library(cowplot)
library(e1071)
library(caret)
library(randomForest)
library(rpart)
library(lattice)
