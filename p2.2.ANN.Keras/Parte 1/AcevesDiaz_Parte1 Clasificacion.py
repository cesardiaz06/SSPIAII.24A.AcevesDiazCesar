# -*- coding: utf-8 -*-
"""
Created on Thu Apr 11 14:19:27 2024

@author: César Alejandro Aceves Díaz
"""

import tensorflow as tf
print(tf.__version__)

#Librerias
import pandas as pd
#scikit-learn
from sklearn.preprocessing import LabelEncoder, OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.model_selection import train_test_split

#Dataset
df_Bank = pd.read_csv('Bank.csv')

X = df_Bank.iloc[:,3:13].values
Y = df_Bank.iloc[:,13].values

#preprocesado
#Dummies
X[:,1] = LabelEncoder().fit_transform(X[:,1])
X[:,2] = LabelEncoder().fit_transform(X[:,2])

one = ColumnTransformer(
    [('one_hot_encoder', OneHotEncoder(categories='auto'),[1])],
    remainder='passthrough'
    )

X = one.fit_transform(X)
X = X[:,1:]

#ESCALADO
X = StandardScaler().fit_transform(X)

#Split
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
              input_dim = 11)
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
              activation = 'sigmoid',
              kernel_initializer = 'uniform')
        )

#Entrenador
ann.compile(optimizer = 'adam',
            loss = 'binary_crossentropy',
            metrics = ['accuracy'])

ann.fit(X_train, Y_train,
        epochs = 90,
        batch_size = 50)

#Guardar modelo
from keras.models import load_model
ann.save('S22.ann.h5')

modelo = load_model('S22.ann.h5')

#prediccion
Y_pred = modelo.predict(X_test)
Y_pred = (Y_pred > 0.5)

#visualizar la arquitectura de la ANN
from keras.utils import plot_model

plot_model(modelo,
           to_file = 'S22.ann.png',
           show_shapes = True,
           show_layer_activations = True,
           show_layer_names = True)

#Matriz de confusión. 
from sklearn.metrics import confusion_matrix

# Calcular la matriz de confusión
cm = confusion_matrix(Y_test, Y_pred)

# Crea un DataFrame de pandas a partir de la matriz de confusión
df_cm = pd.DataFrame(cm, columns=['Predicho 0', 'Predicho 1'], index=['Verdadero 0', 'Verdadero 1'])

# Imprime el DataFrame
print(df_cm)

# ------------------------------------
# ¿Qué fue lo que ajustaste?
"""
Inicie cambiando el número de neuronas que tenía la capa oculta de la red neuronal actual,
pasando de seis a diez, ejecute el código y no noté una mejoría en la exactitud. 

Después de esto, me di cuenta que no debía cambiar la cantidad de neuronas de la capa oculta,
si no que, debía agregar más capas ocultas. Agregué dos extras sin notar una mejoría. 

Posteriormente procedí a modificar los epochs y el batch_size. Inicialmente me excedí al establecer
130 epochs con 50 batch_size, siguió sin cambiar. 

Cambié la función de activación de la capa oculta, antes sigmoid, ahora relu y a partir de ahí fue 
cuando comencé a notar diferencia en una exactitud igual a 85% y un poco superior, llegando hasta 87%. 

Párametros: 1 capa oculta (6 neuronas) con función de activación ReLU, 1 neurona para capa de salida con función
de activación ReLU. 
Epochs = 90.
Batch size = 50.
"""

#¿Por qué?
"""
Realicé estos cambios porque no encontraba variaciones en la exactitud en los primeros cambios, mayoritariamente
fue a prueba y error. 
"""

# Fuente o autor en el que te basaste. 
"""
Cómo ya decía, esto lo realicé más a prueba y error en primera instancia. Una vez que ví fui acercándome al porcentaje 
requerido comencé a investigar el por qué y me basé en varios artículos: 
    * IBM.
    * Aprenderbigdata.com
    * Cloudflare.com
"""

#



