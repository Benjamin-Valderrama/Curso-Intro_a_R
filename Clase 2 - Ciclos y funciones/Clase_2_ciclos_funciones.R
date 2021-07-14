### Clase 2

# Link con la clase anterior ----------------------------------------------

# En la clase pasada conocimos los vectores, un arreglo lineal de datos
vector <- 1:12 ; vector

# Muchas veces nosotros queremos trabajar con arreglos de dos dimensiones.
# En cuyo caso podemos indicarle a R que el vector debe ser transformado 
# a un objeto de 2 dimensiones
dim(vector)<- c(4,3) ; vector

# Ahora que le agregamos una segunda dimension, nuestro objeto deja de ser un
# vector y se transforma en una matriz
class(vector)

# Tambien podriamos crear matrices directamente
matriz<- matrix(data = 1:12, nrow = 4, ncol = 3) ; matriz

# Pero las matrices tienen el siguiente problema: Todos los elementos dentro
# de ellas deben ser del mismo tipo (numeric, logic o character)
matriz[,2]<- as.character(matriz[,2])

# No siempre esto es un problema. Puede ser que nuestros datos sean todos numericos
# y por ende una matriz nos pueda servir. Sin embargo, es mas comun que en nuestros
# datos hayan variables de varios tipos. 

# Para solucionar eso tenemos los dataframes: que permiten tener varias columnas
# y donde cada una de ellas puede ser de un tipo distinto. Sin embargo, los elementos
# dentro de cada columna deben ser todos del mismo tipo


# data frames -------------------------------------------------------------

# NOTA: En la proxima clase vamos a trabajar de forma extensiva con los dataframes.

# Por ahora solo es importante que entiendan que son y vamos a usar uno en particular
# para trabajar con los otros contenidos de esta clase.

# Este dataframe tiene datos de los largos de petalos y cepalos de 3 variedades 
# de plantas. Para poder usarlo, deben correr la siguiente linea de codigo

data("iris")

class(iris) # Nos dice que es un dataframe

iris # Revisemos el primer valor del largo de petalo (1.4 cm)

largo_petalo <- 1.4 # Creamos la variable que contiene ese dato



# Estructuras de control de flujo -----------------------------------------

# En la presentacion vimos que podemos usar estructuras del tipo if/else para 
# ordenarle a R que haga cosas en funcion de si se cumple una condicion o no

petalos_largo= c()

for(petalo in petalos){
        
        if(petalo> 4){
                petalos_largo= c(petalos_largo, "grande")
        }else if(petalo <=4 && petalo >= 2.5){
                petalos_largo= c(petalos_largo, "mediano")
        }else{
                petalos_largo = c(petalos_largo, "pequeno")
        }
}

petalos_largo

# Ejecutamos los ejemplos de la presentacion

# Ejemplo 1
if (largo_petalo > 4){
        # Si es verdad la condicion, ocurre que ...
        print("Es largo")
}


# Ejemplo 2
if(largo_petalo > 4){
        # Si es verdad la condicion, ocurre que ...
        print("Es largo")
} else{
        # Si la condicion no es verdad, ocurre que ...
        print("No es largo")
}


# Ejemplo 3
largo_petalo<-1.4

if(largo_petalo > 4){
        # Si es verdad la condicion, ocurre que ...
        print("Es largo")
        
} else if(largo_petalo > 2.5 && largo_petalo < 4){ # Como vimos en la primera clase: && es AND y || es OR
        # Si no se cumple la primera condicion, se evalua la siguiente. De cumplirse esta, ocurre que ...
        print("Es mediano")
        
} else {
        # Si no se cumple ninguna de las condiciones anteriores, entonces ocurre que ...
        print("Es pequeno")
}



## NOTA: Siempre tener cuidado con las indentaciones y el uso de {}
## NOTA: Se pueden evaluar infinitas expresiones de condicion con else if

# PROTIP: Existe la funcion ifelse. Es de funcionalidad mas limitada, pero de implementacion mas rapida
si<- c()
no<- c()

ifelse(test = iris[,"Petal.Length"] > 4, yes = si<- c(si, "Es largo"), no =  no<- c(no,"Es corto"))


# Ciclos ------------------------------------------------------------------

# Ya vimos la utilidad de las expresiones if/else. Pero aun no revisamos como
# usarlas con objetos que contengan varios datos.

# El detalle de como manipular data frames lo veremos en la proxima clase. Por
# ahora basta con que sepan que la proxima linea de codigo toma todos los valores
# del largos de petalo (cm) que hay en el dataframe y lo almacena dentro del vector
# "petalos"

petalos <- iris$Petal.Length 



# For loop ----------------------------------------------------------------

# 1er tipo de ciclo: For

# Este ciclo permite aplicar una serie de instrucciones a cada elemento dentro de un vector


# La estructura del ciclo for consiste en:
# el comando "for"
# una variable auxiliar llamada "variable"
# un vector, indicado como "vector"

# Basicamente, lo que estamos diciendo aca es que se ejecuten "acciones" para cada
# elemento dentro del vector.

for (variable in vector) {
     # Acciones   
}

# Vamos a adaptar los nombres del ciclo for para nuestro trabajo con los largos de petalo,


# NOTA: Recuerden que la variable "petalos" contiene el vector con los largos de todos los "petalos"
# y que la variable "petalo" es nuestra variable auxiliar. Esta ira tomando el valor
# de cada uno de los petalos en orden, hasta haber recorrido todo el vector. 

for(petalo in petalos) {
        # Accion
        print(paste('El largo del petalo es', petalo, 'centimetros.')) 
        
        # NOTA: Cada vez que queramos "mostrar" el valor de algo
        # dentro de un loop DEBEMOS escribir print(). Si solo escribimos su nombre
        # este solo se leera pero no se mostrara en la consola.
        
        # PROTIP: paste() junta los elementos que estan dentro y los transforma
        # en un character. Ayuda bastante para dejar mensajes mas completos.
}

# Un uso comun del ciclo for es para hacer una transformacion (o evaluar algo)
# en todos los elementos de un vector


# EJEMPLO:

# Creamos 50 notas de promedio 4.5 y sd = 1. Las redondeamos a 1 digito
set.seed(1)
notas <- round(rnorm(n = 50, mean = 4.5, sd = 1), digits = 1) 

# Creamos un vector vacio que va a tener a todos quienes se eximan (notas > 4.0)
eximidos<-c()


# Creamos un ciclo que indica TRUE si se exime o FALSE si no se exime
for(nota in notas){
        
        if (nota > 4){
                print("")
                eximidos <- c(eximidos , T)
        } else {
                print(nota)
                eximidos <- c(eximidos, F)
        }
}

eximidos # Podemos saber cuantas personas se eximen sum(eximidos)


# Por ultimo, alguien podria estar interesado en hacer loops anidados: es decir,
# loops dentro de un loop

iris[1:2, 1:3]

for (fila in 1:2) { 
        for (columna in c("Sepal.Length", "Sepal.Width", "Petal.Length")) {
                print(iris[fila, columna])
        }
}



## COSAS A CONSIDERAR AL TRABAJAR CON FOR LOOPS:

# 1) La variable auxiliar puede tomar cualquier valor. Tradicionalmente se usa "i"
for (i in petalos){
        print(i)
}

# OJO: La variable auxiliar es creada y, en consecuencia, puede sobreescribir una
# variable previa

petalo <- "Hola" ; petalo # Revisar el valor de petalo en environment

for (petalo in petalos){
        # No va a hacer acciones. Solo va a evaluar petalo == a cada elemento del vector petalos
} 

petalo # Revisar el valor de petalo en environment


# 2) Como se vio en los loops anidados: 
# el vector con el que vamos a trabajar puede ser creado dentro del ciclo

for (i in 1:5) {
        print(i+3)
}



# While loop --------------------------------------------------------------

# 2do tipo de ciclo: While

# Este ciclo es especial. Como su nombre lo indica, se va a seguir ejecutando
# hasta que una condicion deje de ser cierta. Esto puede ser muy util para algunas aplicaciones,
# pero si no tenemos cuidado, tambien puede hacer que el computador este calculando
# infinitamente y nunca salgamos del ciclo. (En ese caso, seleccionar el stop en la consola)


# La estructura de un ciclo while consiste en:
# El comando "while"
# La condicion que se debe dejar de cumplir para terminar el ciclo (condicion == FALSE)
# Acciones mientras esa condicion no se cumpla

while (condition) {
        # Acciones
}


# Un ejemplo: Vamos a lanzar una moneda hasta que salga cara (1). Si sale sello (0),
# se lanza de nuevo

moneda<- 0 # Creamos una moneda

# Para asegurar replicabilidad, ponemos una semilla

set.seed(1)
while(moneda == 0){
        moneda <- rbinom(1, 1, 0.5) # Lanza 1 moneda. Cara y sello tienen igual probabilidad (0.5)       
        print(moneda)
}

moneda<- 0 # Reseteamos la moneda
set.seed(86)
while(moneda == 0){
        moneda <- rbinom(1, 1, 0.5) # Lanza 1 moneda. Cara y sello tienen igual probabilidad (0.5)       
        print(moneda)
}

moneda<- 0 # Reseteamos la moneda
set.seed(4000)
while(moneda == 0){
        moneda <- rbinom(1, 1, 0.5) # Lanza 1 moneda. Cara y sello tienen igual probabilidad (0.5)       
        print(moneda)
}


# IMPORTANTISIMO:

# Si olvidamos actualizar la condicion de termino, entonces el ciclo puede que se repita infinitamente
moneda<- 0

while (moneda == 0) {
        rbinom(1, 1, 0.5)
        # Apretar stop en la consola o Esc (teclado)
}



# El ciclo while es muy util para aplicaciones interactivas. Por ejemplo, en situaciones
# donde una pregunta se deba repetir hasta que se entregue un input deseado.








# Funciones propias -------------------------------------------------------

# Todo lo que hemos visto hasta ahora es lo que permite trabajar en R a nivel de "usuario".
# Usamos funciones que estan creadas por otras personas para solucionar problemas comunes.

# Sin embargo, algunas veces no existen soluciones para nuestros problemas, o queremos hacer
# algo tan especifico, que solo nosotros podremos crear una solucion optima para nuestro problema

# En ese caso, o cuando estamos aplicando muchas veces la mismas lineas de codigo a muchos objetos 
# distintos conviene generar nuestras propias funciones


# Estructura de una funcion:
# Como las funciones son objetos para R, se deben definir con un nombre
# Debemos llamar el comando function, que nos va a permitir definir la funcion
# Debemos definir los argumentos que va a usar la funcion
# Indicamos que va a hacer la funcion

mi_funcion <- function(Argumentos){
        #Acciones que va a realizar la funcion
}



# Vamos a crear una funcion que nos va a permitir calcular potencias o logaritmos de numeros
potencias<- function(x, y){
        potencia = x ** y 
        return(potencia) # return() indica valor que va a entregar la funcion
} 

potencias(3,2)


# A CONSIDERAR:

# 1) Ambientes

# NOTA: Las variables creadas dentro de la funcion no existen fuera de ella

potencias_exp_2<- function(x){
        exponente <- 2 # Creo una variable llamada exponente
        potencia = x ** exponente
        return(potencia)
}

exponente # Cuando la llamo fuera de la potencia, R me dice que no existe


# NOTA: Sin embargo, la situacion inversa si puede suceder

mensaje<- "Bienvenidxs al curso"

repetidor<- function(veces){
        # Repite la variable creada fuera de la funci?n la cantidad de veces indicada
        rep(mensaje, veces) 
}

repetidor(3)

# OJO: Noten que aca se uso una funcion ya existente dentro de mi funcion creada


# 2) Que es una funcion?

# Las funciones son un objeto mas dentro de R
class(potencias)
# Entregan resultados ...
potencias(2,3)
# Pero son mas utiles si guardamos esos resultados
resultado <- potencias(2,3) 


# 3) Puedo hacer que las funciones creadas vengan con argumentos predefinidos

# Aca le indico a la funcion que, por defecto, el valor del argumento "operacion" es potencia

pot_o_log<- function(x, y, operacion = "potencia"){
        
        if(operacion == "potencia"){
                resultado = x ** y
                
        } else if (operacion == "logaritmo"){
                
                # OJO ACA: Estamos usando la funcion log (pre-existente) y le damos los argumentos
                # de nuestra funcion a su funcion
                resultado = log(x = x, base = y) 
                
        } else {
                
                # Siempre es bueno que definamos los casos de error de la funci?n y demos un msj pertinente
                return("Operacion invalida")
                
        }
        return(resultado)
} 

pot_o_log(x = 10, y = 2, operacion = "potencia")

# Como definimos que por defecto operacion = potencia, no hay problema si no indicamos el argumento
pot_o_log(x = 10, y = 2) 

# Cambiamos el comportamiento de la funcion indicando otro valor para el argumento operacion
pot_o_log(100 , 10, operacion = "logaritmo")

# Revisamos los casos de error
pot_o_log(10, 2, operacion = "suma")




# MENSAJES PARA LA CASA:

# 1) Las funciones que pueden crear uds permiten dar valores predefinidos,
# y tambien usar funciones que ya existen. Por tanto, sus funciones 
# van a ser tan utiles como creatividad tengan uds. 

# 2) Esto es recien el inicio de lo que se puede hacer con funciones. 
# Si quieren aprender mas, les recomiendo revisar los libros de la bibliografia 



# DESAFIO -----------------------------------------------------------------

# Esta clase tiene 3 desafios. Las instrucciones vienen en el archivo
# Clase 2 - Desafios. 

# Si los quieren realizar, haganlos en ese mismo archivo de R y los 
# revisamos en conjunto durante la proxima clase

# EJERCICIO ---------------------------------------------------------------


# MINI EJERCICIO: Queremos crear un algoritmo que nos indique, para cada elemento 
# del vector petalo, a que categoria de tamano corresponde. 
# El resultado debe ser guardado en un unico vector llamado "categoria".

# Los petalos mas grandes que 4 cm deben ser asignados como "Grandes", 
# los petalos entre 2.5 y 4 cm deben ser asignados como "Medianos" y 
# los petlos mas pequenos de 2.5 cm deben ser asignados como "Peque?o"