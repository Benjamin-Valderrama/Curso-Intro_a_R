### Clase 3: Trabajo con dataframes


# Datasets en R -----------------------------------------------------------

# R viene con varias bases de datos incorporardas en su instalacion.
data() # Para ver la lista

data(iris) # Para importar la base de datos llamada iris

iris # Para revisar las bases de datos

View(iris)


# Sin embargo, muchas veces vamos a querer trabajar con datos que no vengan en R.
# Para eso tenemos que perderle el miedo a importar datos a R.

# Como nos quitamos ese miedo? Con este curso :D


# Para aprender a importar datos, antes tenemos que entender un poco (muy poco) 
# sobre como funciona el computador


# Un poco de como movernos dentro del computador --------------------------

# El computador funciona de manera muy ordenada en "directorios". Para llegar a ellas, 
# el computador usa "rutas" que van desde el disco duro hasta la carpeta que tiene 
# nuestros datos

# Por eso en la primera clase creamos un R project (que abrimos al inicio de cada clase)
# De esta forma tenemos una ruta similar desde el proyecto de R a nuestros datos.

# Podemos preguntarle a nuestro PC donde estamos parados dentro de su disco duro

getwd() # Nos dice donde esta el directorio de trabajo (nuestro proyecto R)


# Podemos movernos dentro de sus carpetas

# Usando la interfaz grafica:

# O con instrucciones directas
setwd() # Podemos modificar el directorio de trabajo


ls() # Para saber que objetos estan creados en nuestra sesion de R

list.files() # Nos dice los archivos que hay dentro de nuestro directorio


dir.create() # Sirve para crear carpetas. Se crean en el directorio de trabajo



## PROTIP:
# En general, cuando tengamos un proyecto creado, vamos a crear 
# una carpeta con los datos crudos (sin procesar), 
# una carpeta con los datos procesados
# Una carpeta con los resultados mas relevantes (figuras, tablas, etc)


# Importar datos ----------------------------------------------------------

# Como dijimos, muchas veces queremos trabajar con las bases de datos externas. 
# ya sea porque nos las envian para que hagamos un analisis, o porque nosotros
# registramos esos datos como parte de un experimento.


# Existen varios formatos tipicos para almacenar bases de datos.
# Los mas comunes son los archivos ".txt" (de texto), 
# ".csv" (valores separados por coma), ".xlsx" (hojas de excel)


## Vamos a importar archivos de texto.
autos_txt<- read.table(file = paste0(getwd(),"/adatos_filtrados/mtcars.txt"),
                       header = F, 
                       row.names = 1,
                       dec = ".",
                       sep = " ")

# Revisamos la tabla
autos_txt
View(autos_txt)

# Revisen todas las otras opciones que permite esta funcion
?read.table


## Importamos archivos separados por coma (csv)
autos_csv<- read.csv(file = "mtcars.csv",
                     header = T,
                     row.names = 1,
                     dec = ".",
                     sep = ";")


# Revisamos la tabla
autos_csv
View(autos_csv)

# Revisen todas las otras opciones que permite esta funcion
?read.csv


## Importamos archivos excel (xlsx)
# Para esto necesitamos usar una libreria externa, que no viene con R

# Instalamos si es que ya no esta instalada
if(!"readxl" %in% installed.packages()){
        install.packages("readxl")
}

# Ahora que esta instalada, se debe cargar en la memoria para usar sus funciones
library(readxl)
# https://www.java.com/en/download/manual.jsp


nombres_1970<- read_xlsx(path = "nombres.xlsx", 
                         sheet = "1970",
                         col_names = T,
                         skip = 3,
                         n_max = 14)


# Esta funcion tiene muchisimos argumentos que entregan mucha flexibilidad
?read_xlsx


# NOTA: Esta forma de importar datos genera tibbles, no "data frames".
# Los tibbles, tal como los data.frames, son otro arreglo de datos en 2-dimensiones

# Sin embargo, el tibble se puede transformar a data frame
nombres_1970_df<- as.data.frame(nombres_1970)


# Exportar datos ----------------------------------------------------------

# Tal como existen las funciones read.csv o read.table, existen las funciones
# para escribir datos en formato ".csv" o ".txt"

# Por ejemplo, usaremos la base de datos "iris", que ya importamos previamente
iris

# Lo vamos a exportar la base de datos en formato .txt
write.table(x = iris,
            file = "iris.txt")

# Al igual que las funciones que permiten importar, las que permiten exportar
# tienen muchisimos argumentos que dan mas flexibilidad

# Por ejemplo
write.table(x = iris,
            file = "iris_sin_rownames.txt",
            row.names = F)

# Vamos a ver los dos archivos


# NOTA: FIJENSE que se cambio el nombre del archivo final. 
# Si se usa una funcion para exportar archivos, si el lugar de destino (directorio)
# tiene un archivo con ese nombre, este se va a sobreescribir y el existente se perdera


# Lo vamos a exportar en formato .csv
write.csv(x = iris,
          file = "iris.csv",
          row.names = F)


# Adicionalmente existe la libraria readr que tiene funciones que realizan 
# trabajos parecidos pero con mas argumentos que permiten adaptarse mejor a
# nuestras necesidades de importacion o exportacion de datos

# Por ejemplo, permiten definir el tipo de variable de cada columna, entre muchas
# otras.


# Manipulacion de los dataframes ------------------------------------------

# Tenemos el dataframe que queremos trabajar
data("mtcars")

# Algunas veces podremos ver los datos completamente, pero muchas veces
# tendremos tantos datos que seria imposible verlos de forma detenida. En esos 
# casos requerimos de funciones que nos ayuden a comprender mejor nuestros
# datos


# Lo primero que podemos hacer es darle una mirada a las primeras (o ultimas)
# filas de nuestros datos

#     _________         _________
#    /         \       /         \   
#   /  /~~~~~\  \     /  /~~~~~\  \  
#   |  |     |  |     |  |     |  |
#   |  |     |  |     |  |     |  |       tail()
#   |  |     |  |     |  |     |  |         /
#   |  |     |  |     |  |     |  |       //
#  (o  o)    \  \_____/  /     \  \_____/ /
#   \__/      \         /       \        /
#    |         ~~~~~~~~~         ~~~~~~~~
#    ^
#  head()  

head(mtcars)
head(mtcars, n = 10)

tail(mtcars)
tail(mtcars, 10)


# Podemos preguntar cuantos datos y variables tiene nuestro dataframe

# En general, cuando un dataframe esta ordenado, cada fila es una observacion
# y cada columna es una variable medida a ese mismo dato. Esto es lo que se 
# conoce como "tidy data" y, aunque suena algo obvio y optimo para el trabajo,
# la mayoria de las personas no guarda sus datos de forma ordenada.


dim(mtcars) # 32 (filas), 11 (variables). 


# Podemos preguntar los nombres de las filas y de las columnas
colnames(mtcars)
row.names(mtcars)

# Son vectores
colnames(mtcars)[1:3]

# Podemos redefinirlos
colnames(mtcars)[1] <- "millas_por_galon" 
head(mtcars)

# Tambien podria usar un vector con muchos nombres
colnames(mtcars)<- paste(rep("v", 11), 1:11, sep = "")
head(mtcars) # Explicarlo paso a paso


# Dejamos el mtcars como estaba antes
data("mtcars")


# Hay funciones que nos permiten conocer resumenes de nuestros datos
str(mtcars) # str significa "structure".
summary(mtcars)

# NOTA: Al revisar nos damos cuenta que la variable vs, es una variable categorica,
# pero R lo interpreto como una variable numerica.

# Podemos modificar las variables de un dataframe a voluntad ($)
class(mtcars$vs) # $ como opcion a [], pero para nombres de las variables

mtcars$vs<- as.factor(mtcars$vs)

class(mtcars$vs)

summary(mtcars)


# Otra forma de seleccionar datos dentro de un dataframe es con indices
mtcars[,]

# Fila
mtcars[1,]
mtcars[1:3,]
mtcars[c(1:3, 5),]

# Columnas
mtcars[,1]
mtcars[,1:3]
mtcars[,c(1:3, 5)]

# Ambas
mtcars[1:3, c("mpg", "cyl", "disp", "drat")]



# Integramos: Importar, Manipular, Exportar, Trabajo ordenado -------------

# EJEMPLO: tipico de trabajo con datos

# Nos dieron los datos crudos de mtcars (todos los datos en el .txt)
# A nosotros nos importan solo los datos de autos con 8 cilindros y mas de 210 caballos de fuerza.

# Importamos los datos crudos en R
autos_txt # Eso lo hicimos antes y lo guardamos en este objeto

# procesamos los datos
autos_filt <- subset(autos_txt, cyl == 8 & hp > 210)

# creamos una carpeta para los datos filtrados
if (!dir.exists("datos_filtrados")){
        dir.create("datos_filtrados")
}


# exportamos el data.frame procesado
write.table(x = autos_filt, 
            file = paste(getwd(), "/datos_filtrados/autos_filtrados.txt"))



# DESAFIO: Dataframes + funciones -----------------------------------------

# Las instrucciones quedan en el archivo Clase 3 - Desafios.R

# La proxima clase discutimos las soluciones 