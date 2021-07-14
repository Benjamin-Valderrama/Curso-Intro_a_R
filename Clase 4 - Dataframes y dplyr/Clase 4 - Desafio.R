# DESAIO -------------------------------------------------------------------

# Para esta tarea deben leer un objeto en un formato propio de R, el formato .rds
# para eso usamos una funcion que no vimos anteriormente, pero que en su forma basica
# se usa como un read.csv

# Los datos son parte de un censo realizado en 2015 en EEUU. Hay 50 estados, pero dentro
# de ellos hay counties, que serian regiones más pequeñas. 
# Por ejemplo: en Los Angeles, California, California seria un estado (state en la data), 
# mientras que Los Angeles seria un county (county en la data)

# Hay mucha informacion en este dataset (40 variables y 3138 observaciones).

# Algunas variables que vamos a usar y, por tanto, merecen la pena ser explicadas:

# population: La cantidad de gente que vive en ese lugar
# men: Machos viviendo en el lugar
# women: Hembras viviendo en el lugar

# hispanic: % de la poblacion que corresponde a este grupo
# white: % de la poblacion que corresponde a este grupo
# black: % de la poblacion que corresponde a este grupo
# native: % de la poblacion que corresponde a este grupo
# asian: % de la poblacion que corresponde a este grupo

# metro: Si tiene metro o no el lugar

# priveate_work: Gente que trabaja para compañias
# public_work: Gente que trabaja para el gobier
# self_employed: Gente que trabaja independiente



# Preguntas para responder ------------------------------------------------


# 1) Queremos saber cuantos machos y hembras hay en cada estado


# 2) Queremos saber cuantas personas en total viven en las los estados


# 3) Cuales son los 3 estados que tienen mayor cantidad de desempleados


# 4) Cuales son los 5 estados que tienen los niveles mas bajo de desempleo?


# 5) Cuales son los 3 counties del estado de texas que tienen mayor proporcion de
# mujeres


# 6) Comprar la densidad poblacional en las zonas con metro y sin metro 


# 7) Queremos saber si el ingreso per capita promedio es mas bajo en estados
# que tienen menor cantidad de personas con ascendencia afroamericana. 


## 8) Ahora te toca a ti... 

# Puedes responder una pregunta que te interese con esta
# base de datos o puedes usar una base de datos distinta. Lo importante es que
# uses las funciones de dplyr para responder las preguntas y que trates de usar
# todas las funciones que vimos