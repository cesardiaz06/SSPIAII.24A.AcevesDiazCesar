# -*- coding: utf-8 -*-
"""
Created on Thu Apr 18 02:56:50 2024

@author: César Alejandro Aceves Díaz.
"""


"""
Se optó por predecir el CreditScore de los clientes tomando como consideración el resto de variables,
la columna de países se pasó a "factores" (creo) al igual que la columna de género.
"""

import tensorflow as tf
print(tf.__version__)

#Librerias
import pandas as pd
import numpy as np
#scikit-learn
from sklearn.preprocessing import LabelEncoder, OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.model_selection import train_test_split

#Dataset
df_Bank = pd.read_csv('Bank.csv')

X = df_Bank.iloc[:,3:13].values
Y = df_Bank.iloc[:,3].values

#Preprocesado.

#Obtener los países que aparecen en el dataset.
columna_paises = X[:,1]
paises = np.unique(columna_paises) #Obtener todos los países presentes en la columna.

# Crear un diccionario de mapeo para crear factores de columna países.
dicc_paises = {'Spain': 1, 'France': 2, 'Germany': 3}
dicc_gen = {'Female':1,'Male':2}

# Reemplazar los valores en la columna
X[:,1] = np.array([dicc_paises[pais] if pais in dicc_paises else pais for pais in X[:,1]])
X[:,2] = np.array([dicc_gen[genero] if genero in dicc_gen else genero for genero in X[:,2]])


#Escalado de los datos
X = StandardScaler().fit_transform(X)
 
#Crear Split. 
X_train, X_test, Y_train, Y_test = train_test_split(X, Y,
                                                    test_size=0.2,
                                                    random_state=10)

#Modelo ANN
from keras.models import Sequential
from keras.layers import Dense

ann = Sequential()

#capa de entrada
ann.add(
        Dense(units = 6,
              kernel_initializer='uniform',
              input_dim = 10)
        )

#capas ocultas
ann.add(
        Dense(units = 6,
              kernel_initializer='uniform',
              activation = 'relu')
        )

#capa de salida
ann.add(
        Dense(units = 1,
              activation = 'linear',
              kernel_initializer = 'uniform')
        )

#Entrenador
ann.compile(optimizer = 'adam',
            loss = 'mean_squared_error',
            metrics = ['mean_absolute_error'])

ann.fit(X_train, Y_train,
        epochs = 50,
        batch_size = 50)



#Guardar modelo
from keras.models import load_model
ann.save('Regresion.h5')

modelo = load_model('Regresion.h5')

#prediccion
Y_pred = modelo.predict(X_test)

#Calculo de mean_squared_error. 
from sklearn.metrics import mean_squared_error

mse = mean_squared_error(Y_test, Y_pred)

#Gráfica del modelo de regresión. 
import matplotlib.pyplot as plt

plt.figure(figsize=(10,6))

plt.scatter(Y_test, Y_pred)

plt.plot([min(Y_test), max(Y_test)],[min(Y_test),max(Y_test)],color='red')

plt.title('Valores verdaderos vs Predicciones')

plt.xlabel('Valores Verdaderos')
plt.ylabel('Predicciones')

plt.show()