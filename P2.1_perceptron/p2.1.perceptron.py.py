# -*- coding: utf-8 -*-
"""
Created on Sat Apr 13 22:16:37 2024

@author: César Alejandro Aceves Díaz. 
Actividad: P2.1 - ANN pura
"""

#Librerías
import random as rd
import math

#Dataset
dataset = [
    {"entrada": [0, 0, 1], "salida": 0},
    {"entrada": [1, 1, 1], "salida": 1},
    {"entrada": [1, 0, 1], "salida": 1},
    {"entrada": [0, 1, 1], "salida": 0}
]

dataset[0]


class ANN:
    def _init_(self):
        rd.seed(2002)
        self.__pesos = [
            rd.uniform(-1, 1),
            rd.uniform(-1, 1),
            rd.uniform(-1, 1),
            rd.uniform(-1, 1)
        ]

    #Funciones dentro del core.
    def __nucleo(self, entradas):
        suma = 0
        for i, entradas in enumerate(entradas):
            suma += self.__pesos[i] * entradas
        return suma

    #Función de activación, sigmoide = 1 / (1+e^(-x))
    def __factivacion(self, score):
        return 1 / (1 + math.exp(-score))

    #predicción = salida.
    def predict(self, datos):
        score = self.__nucleo(datos)
        y_pred = self.__factivacion(score)
        return y_pred

    #Función de coste, coste =
    def __fcoste(self, y_pred, y_actual):
        return ((y_pred - y_actual) ** 2) / 2

    #Obtener pesos.
    def getPesos(self):
        return self.__pesos

    #Entranamiento.
    def training(self, datos, epochs):
        for epoch in range(epochs):
            for obs in datos:
                y_pred = self.predict(obs["entrada"])
                coste = self.__fcoste(y_pred, obs["salida"])

                error = obs["salida"] - y_pred

                #Ajustar pesos.
                for index in range(len(self.__pesos)):
                    entrada = obs["entrada"][index]
                    adj = entrada * coste * error
                    print("Pesos adj: ", index, "[", epoch, "]: ", adj)
                    self.__pesos[index] += adj


#Modelo
neurona = ANN()
print("Pesos iniciales: ", neurona.getPesos())

#Entrenamiento
#neurona.training(dataset, 1)

#Predicción
prediccion = neurona.predict([0, 0, 1])