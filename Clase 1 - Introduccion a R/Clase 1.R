# PEQUE?O CONTEXTO
# R es un lenguaje dise?ado para el manejo y visualizaci?n de datos y c?lculo.
# Es b?sicamente una "super calculadora gr?fica". Actualmente existe 
# una amplia red de usuarios que desarrolla funciones y paquetes que transforman 
# esta super calculadora en una herramienta "necesaria" para cualquier persona
# que trabaje entorno a datos en un contexto cient?fico.

# C?mo es una calculadora, lo m?s b?sico que podemos hacer con R es hacer operaciones
3 + 3 # Ejecuta la linea con Ctrl+Enter

# De esta forma ver?s '6' en la consola. Una ventaja de R es que se ejecuta 
# "por linea". Tambi?n podemos ejecutar varias lineas seleccionandolas todas y
# apretando Ctrl+Enter
2 + 2
4 + 2
6 + 2
8 + 8


# Operadores --------------------------------------------------------------

# Existen varios operadores en R:
# Aritm?ticos
5 - 5
5 * 5
5 / 5
5 ^ 5   # igual que 5 ** 5
5 %% 2  # calcular el resto
5 %/% 2 # divisi?n entera

# Relacionales
5 < 5
5 > 5
5 <= 5
5 >= 5
5 == 5
5 != 5 

# L?gicos
!TRUE
TRUE && FALSE
TRUE || FALSE


# Variables y sus clases --------------------------------------------------

# La forma en la que opera R es bastante sencilla: se definen variables y a estas
# se le aplican funciones. Estas variables son referencias a informaci?n almacenada
# en nuestro computador. Y las funciones son algoritmos o "instrucciones" a los
# que se somete esta variable (las veremos la pr?xima clase)
assign('a',1)

# La variable con nombre 'a' es una referencia hacia el valor numerico '1'. 
# La funci?n assign() puede ser reemplazada por los simbolos '=' o '<-'
a = 1
a <- 1 # El atajo para este simbolo es Alt+'-'

# De esta forma correr la siguiente linea deber?a imprimir '1' en la consola
a

# Tambi?n funciona si seleccionamos un 'a' en cualquier parte del c?digo y 
# apretamos Ctrl+Enter.
# PROTIP: escribir ';' despu?s de definir una variable y luego escribir su nombre,
# la define e imprime en un solo paso.
b = 2; b

# Podemos definir variables y operar con ellas
a + b

# Adem?s existen otros tipos de variables
c <- "Hola" # character
d <- 1.3    # numeric
e <- T      # logical
f <- F      # logical

# Podemos conseguir la clase de una variable usando la funci?n class()
class(c)

# Y las clases pueden ser modificadas con las funciones del tipo as.nuevotipo(). Por ejemplo:
t <- TRUE ; class(t) # Creamos un objeto y le preguntamos la clase de este. 

t = as.character(t) # Cambiamos la clase del objeto
class(t) # Revisamos la nueva clase


as.character(1)
as.logical(1)
as.logical(0)

# Pero no todas las clases pueden ser transformadas a otras
as.numeric("b")

# Por ?ltimo, las variables se pueden redefinir
a = 2; a
a = TRUE; a
a = 'a'; a


# Vectores ----------------------------------------------------------------

# Una herramienta ?til de R son los vectores
vector <- c(1,2,3,4,5); vector

# Muchas funciones de R est?n vectorizadas, lo que significa que operar?n sobre 
# cada elemento de un vector
vector * 3
vector >= 2

# PROTIP: 
# Una herramienta muy ?til en R se puede generar mezclando lo que aprendimos sobre:
# 1) las clases de las variables y 2) las operaciones en vectores

# Podemos saber cuantos elementos dentro de un vector cumplen una determinada condici?n:
# Por ejemplo, queremos saber cuantos elementos dentro del vector "vector" son m?s grandes o iguales a 3
vector >= 3 # Entrega un vector de valores TRUE o FALSE
sum(vector >= 3) # Suma los valores TRUE (porque TRUE es igual a 1)


# Funciones para crear vectores
secuencia = 1:10; secuencia
repetido = rep(x=1, times=10); repetido

# Podemos acceder al largo del vector
length(vector)

# Una buena pr?ctica en programaci?n es asignarle a las variables un nombre con
# significado. Debemos pensar que un c?digo tiene que poder ser leido no solo
# por nosotrxs en el momento, sino por nosotrxs en unas semanas, meses o 
# a?os en el futuro, y tambi?n por otras personas. 


# Nos detendremos con 'rep' para explicar la estructura b?sica de una funci?n
# Aqu? la funci?n 'rep' tiene 2 argumentos: 'x' y 'times'. No siempre es necesario
# espec?ficar los argumentos, aunque esto significa ponerlos "en orden"
rep(x='hola', times=3)
rep('hola', 3)

# NOTA: Un vector solamente puede almacenar un tipo de variable. 
# Si tratamos de hacerlos mixtos el vector forzar? una transformaci?n para que 
# todos los elementos sean de la misma clase.
vector_mixto = c(1, "hola", TRUE); vector_mixto


# Revisar seq
?seq
help("seq")

# Mini tarea
# Has un vector que vaya desde el 1 al 1000 en pasos de 20. Almac?nalo en una variable llamada vector_uno_mil
# Has un vector que vaya desde el 1000 al 1 en pasos de 20. Almac?nalo en una variable llamada vector_mil_uno
# Genera un vector de largo mil que siga con la secuencia 1,1,0,0,1,1,0,0...

# tambi?n se pueden generar vectores con n?meros pseudo-aleatorios
rnorm()
runif()

# Hacer un vector de 1000 numeros con distribuci?n normal con media 10 y sd 3. Almac?nalo en una variable llamada vector_normal
# Hacer un vector de 1000 n?meros entre el -500 y 500. Almac?nalo en una variable llamada vector_uniforme

# Para poder reproducir ejemplos aleatorios usamos 
set.seed()

# Consistentes
rnorm()
runif()

# Busca la funcion sample() y usala para general un dado.

# Funciones para vectores
x = vector
min(x); max(x); mean(x); median(x); sd(x); var(x)
sort(x, decreasing=TRUE)

# Para acceder a un elemento en particular dentro de un vector usamos los indices
x[1]
x[2:4]

# Mini Tarea
# Genera un forma de acceder al ultimo elemento de un vector, sin importar su largo








