### Clase 4: Paquete dplyr


# Tidyverse ---------------------------------------------------------------


# Vamos a instalar los paquetes del ecosistema tidyverse
if(!"tidyverse" %in% installed.packages()){
        install.packages("tidyverse")
}

library(dplyr)


# Dentro de tidyverse encontramos muchos paquetes útiles para el trabajo con datos
# 2 de los más conocidos y que vamos a usar en este curso son (1) dplyr, que nos permite
# trabajar con dataframes de manera ágil y manipular datos para extraer información
# de ellos, y (2) ggplot2, que nos va a permitir hacer gráficos personalizables

# Estos paquetes funcionan en conjunto y tienen a un grupo de desarrolladores que los
# estan agrandando, optimizando y revisando constantemente

# https://towardsdatascience.com/what-you-need-to-know-about-the-new-dplyr-1-0-0-7eaaaf6d78ac

# Importamos los datos ----------------------------------------------------

# Por mientras vamos a importar una base de datos que contiene la frecuencia con 
# que se registraron personas bajo distintos nombres en Chile por año (1970 - 2019)

library(readxl)

data<- read_xlsx(path = "nombres.xlsx")
class(data) # tibble

data<- as.data.frame(data) 
class(data) # ahora es dataframe


## PARENTESIS:
# La funcion read_excel es tremendamente poderosa. Tiene muchisimos argumentos
demostracion<- read_excel(path = "nombres.xlsx",
                          sheet = 2,
                          skip = 3)

?read_excel
## FIN DEL PARENTESIS

head(data)

str(data) # Vemos que sexo es character, cuando debería ser categorica

data$sexo<- as.factor(data$sexo)
str(data) # Ahora si


# Revisamos un resumen de los datos
summary(data)


# dyplr -------------------------------------------------------------------

# Ahora que hicimos una pequeña manipulacion de datos para tenerlos en el 
# formato que necesitamos, podemos comenzar a responder preguntas con los datos

# Las preguntas pueden ser complejas o sencillas. 
# Todo va a depender de lo que nos interese


# Para responder esas preguntas, vamos a usar funciones que son parte del paquete
# dplyr. Sin embargo, aquí vamos a ver solo algunas funciones. dplyr es un paquete
# en constante crecimiento y, por tanto, hay muchas funciones mas avanzadas que nos 
# permiten hacer cosas mas complejas o, por otro lado, nos permite hacer cosas que se 
# pueden hacer con las funciones normales de R, pero con menos lineas de codigo


# %>% ---------------------------------------------------------------------

# Lo primero que vamos a ver es el concepto de pipeline " %>% " (Ctrl + Shift + M) 
# este simbolo es parte del paquete dplyr (por lo que cuando queramos usarlo, tendremos
# que importar dplyr previamente). Este símbolo nos permite hacer que el output de una
# funcion, entre directamente en la siguiente para ser procesado



# filter: me quedo con las observaciones (filas) que cumplen una condicion --------


# Supongamos que queremos ver los 10 nombres menos comunes asociados al sexo "F" en el año 2010

# 1) Deberíamos tomar nuestros datos y seleccionar sólo las observaciones del año 2010

colnames(data) 

data_2010<- data %>% filter(anio == "2010") # Filter nos permite seleccionar filas

data_2010 %>% head()

dim(data)
dim(data_2010)


# 2) Queremos quedaros solamente con la con los nombres asociados al sexo F 
# en el año 2010

data_2010_F<- data %>% filter(anio == "2010", sexo == "F")

data_2010_F %>% head()

# Noten que podemos quedarnos con las filas que cumplan todas las condiciones que 
# establescamos

dim(data)
dim(data_2010)
dim(data_2010_F)



## OJO: Si ninguna fila cumpla con las condiciones el resultado es un dataframe
# vacio

data %>% filter(anio == "2021") %>% dim()

data_feo<- data %>% filter(anio == "2021")


# select: Selecciono columnas ---------------------------------------------

# https://tidyselect.r-lib.org/reference/select_helpers.html

# 3) Queremos quedarnos solamente con las columnas nombre y n del dataframe 
# data_anio_F. Para eso usamos la funcion select() ...

data_2010_F_name_n<- data %>% 
        filter(anio == "2010", sexo == "F") %>% 
        select(c("nombre", "n"))

data_2010_F_name_n %>% head()

# Una forma alternativa de obtener lo mismo usando - 
data %>% 
        filter(anio == "2010", sexo == "F") %>% 
        select(-c("anio", "sexo", "proporcion")) %>% 
        head()



# arrange: ordeno los datos segun alguna variable -------------------------

# 4) Al revisar el head del dataframe podemos ver que los datos estan ordenados
# de mayor a menor (situacion que no es comun). Nosotros queremos saber los nombres
# menos comunes, asi que debemos ordenarlos de menor a mayor


data_2010_F_name_n_desc<- data %>% 
        filter(anio == "2010", sexo == "F") %>% 
        select(c("nombre", "n")) %>% 
        arrange(n)

data_2010_F_name_n_desc %>% head()

# Como pueden notar, por defecto la función arrange ordena de menor a mayor.
# Si quiero el comportamiento inverso (ordenar de mayor a menor), debo indicarlo
# con la función desc()

# OJO, que el objeto data_2010_F_name_n_desc es el objeto que acabamos de crear
# y que tiene los datos ordenados por la cantidad de personas que llevan determinado
# nombre en orden ascendente. 

data_2010_F_name_n_desc %>% arrange(desc(n)) %>% head() # Obtenemos el orden original


# PROTIP: arrange permite ordenar los vectores del tipo character. Esto lo hace por
# orden alfabetico. Por ejemplo, ordenmos los nombres asociados a F del año 2010 por
# orden alfabetico


data %>% 
        filter(anio == "2010", sexo == "F") %>% 
        arrange(nombre) %>% 
        head() # Vemos que parten con A

data %>% 
        filter(anio == "2010", sexo == "F") %>% 
        arrange(nombre) %>% 
        tail() # Vemos que terminan con la Z

# Tambien puedo usar más de una variable para ordenar mis datos
data %>% 
        arrange(nombre, n) %>%  # Noten el comportamiento anidado
        head(20) 

data %>% 
        arrange(n, nombre) %>%  # Noten el comportamiento anidado + Orden de variables
        head(20) 

data %>% 
        arrange(nombre, desc(n)) %>% # Comportamiento anidado + mescla de ascendentes
        head(20) # descendentes




# slice_: selecciono algunas observaciones --------------------------------


# Muy entretenido esto de ordenar, pero de que sirve? Bueno, podemos ayudarnos 
# de otras funciones para obtener los n casos que cumplan una condicion.

# Por ejemplo: queremos conocer los 3 nombres más populares asociados a M y F 
# en el año 2000.


# Una opción es hacer lo siguiente
data %>% 
        filter(anio == "2000", sexo == "F") %>% 
        arrange(desc(n)) %>% 
        slice_head(n = 3)

data %>% 
        filter(anio == "2000", sexo == "M") %>% 
        arrange(desc(n)) %>% 
        slice_head(n = 3)


# group_by: agrupo los datos segun una variable ---------------------------

# Pero otra opción aun mejor (porque no necesita hace copy-paste y porque requiere
# menos lineas de codigo) puede ser usando una nueva funcion, llamada group_by()

data %>% 
        filter(anio == "2000") %>% 
        group_by(sexo) %>% 
        arrange(desc(n)) %>% 
        slice_head(n = 3)

# Si quisieramos ver los menos comunes hacemos el corte en la parte final

df<-data %>% 
        filter(anio == "2000") %>% 
        group_by(sexo) %>% 
        arrange(desc(n)) %>% 
        slice_tail(n = 3) %>% 
        ungroup()


# Como podran imaginar, group_by(), al igual que otras funciones de dplyr,
# permite tomar mas de una variable como argumento, lo que la vuelve muy 
# versatil


# Estas preguntas son poco más complejas, pero pueden ser resueltas con dplyr

# 1) Cual es el nombre más comun (M y F) en cada año y cuantas personas 
# fueron registradas con ese nombre?

data %>%
        group_by(anio, sexo) %>% # Notar el comportamiento anidado
        arrange(desc(n)) %>% 
        slice_head() %>% # n = 1 por defecto
        select(-proporcion) %>% 
        View()# Quitamos la proporcion 
        
        
# 2) Ahora que tenemos ese codigo, podemos preguntarnos en cuales años un
# nombre fue el más popular

data %>% 
        group_by(anio, sexo) %>% 
        arrange(desc(n)) %>% 
        slice_head() %>%
        filter(nombre == "Juan") %>% 
        select(anio)

# Si se fijan, seleccionamos solo los años, pero nos arroja una dataframe
# de años y sexo. Esto es porque los datos siguen agrupados 
# (en la consola lo dice)


data %>% 
        group_by(anio, sexo) %>% 
        arrange(desc(n)) %>% 
        slice_head() %>%
        filter(nombre == "Juan") %>% 
        ungroup() %>% # Aca se desagrupan los datos
        select(anio)

data %>% 
        group_by(anio, sexo) %>% 
        arrange(desc(n)) %>% 
        slice_head() %>%
        filter(nombre == "Juan") %>% 
        ungroup() %>% # Aca se desagrupan los datos
        select(anio) %>% 
        pull() # Extraerlo como un vector


# En general no es terrible que los datos queden agrupados, pero dependiendo
# de lo que quieran hacer, van a tener que prestar atencion a que 
# transformaciones estan aplicando a sus datos en cada paso



# mutate: creamos nuevas variables ----------------------------------------

# Supongamos que originalmente nuestros datos solo contenian informacion 
# respecto al año, el sexo, nombre y la cantidad (n), sin incluir la
# proporcion. Es decir, seria algo asi

data_sin_prop<- data %>% 
        select(-proporcion)

# Siguendo con el ejercicio, supongamos que nos interesa saber la proporcion
# que representa cada nombre en cada año. Para eso usamos una nueva funcion
# mutate(), que nos permite crear nuevas variables usando otras existentes

data_sin_prop %>%
        group_by(anio, sexo) %>% 
        mutate(nacidos_totales_por_año = sum(n)) %>% 
        mutate(proporcion = n / nacidos_totales_por_año) %>% 
        View()

data$proporcion == data_restaurado$proporcion # Todos los valores son distintos? POR QUE?



# Qué es lo correcto, lo que hicimos nosotros o lo que estaba en la base de datos?
# Bueno, revisemos que paso con las herramientas que hemos aprendido...

# Tomemos como referencia el año 1970. Revisamos en los datos originales 
# si los numeros de las proporciones cuadran

data_1970<- subset(data, 
                   subset = anio == "1970", 
                   select = "proporcion") %>% # Enfasis en dplyr vs base
        sum()

data_1970



data_rest_1970<- subset(data_restaurado, 
                        subset = anio == "1970", 
                        select = "proporcion") %>% # Enfasis en dplyr vs base
        sum()

data_rest_1970 # 2 porque sumamos el 100% de M y el 100% F


## PORQUE HACEMOS ESTO? Porque muchas veces es necesario hacer una revision
# rapida para asegurarnos de que los datos parezcan confiables y hagan sentido.
# Idealmente esta revision debe hacerse antes de comenzar con otros analisis
# para no perder el tiempo


# summarise ---------------------------------------------------------------

# Una forma rapida de agrupar datos y conocer resumenes de mis datos
# es con el verbo summarise (o summarize)

# Es por eso que Summarise se acompaña muy bien de las funciones 
# mean(), max()/min(), o sum()


# EJEMPLOS:


# Queremos saber la cantidad de personas nacidas en cada año
data %>% 
        group_by(anio) %>% 
        summarise(total_nacimientos = sum(n))


# Podemos hacer summarise para agrupaciones de mas de una variable

# Total de nacimientos en cada año separados por sexo
data %>% 
        group_by(anio, sexo) %>% 
        summarise(total_por_sexo_y_anio = sum(n))



# Tambien podemos estar interesados en construir una tabla de resumen:

# 1) Queremos saber, para cada nombre, cuantas veces ha sido usado
data %>% 
        group_by(nombre) %>% 
        summarise(total_de_registradxs = sum(n))


# 2) En promedio (a traves de los años) cuantas veces ha sido registrado cada nombre
data %>% 
        group_by(nombre) %>% 
        summarise(promedio_de_usos = mean(n))

# 3) Resumen de los nombres:
data %>% 
        group_by(nombre) %>% 
        summarise(total_de_registrados = sum(n), 
                  veces_que_mas_se_uso = max(n),
                  veces_que_menos_se_uso = min(n),
                  promedio_de_usos = mean(n))


# DESAFIO -----------------------------------------------------------------

# Ahora que hemos visto como se trabaja con grandes cantidades de datos,
# vamos a completar un desafio que pondra a prueba lo aprendido durante las 
# clases.

# Las instrucciones las encontraran en el archivo Clase 4 - Desafio.R
