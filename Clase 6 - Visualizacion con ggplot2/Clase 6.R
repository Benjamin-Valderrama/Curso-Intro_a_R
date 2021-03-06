# 'ggplot2' es un paquete para graficar y est� dentro del paquete 'tidyverse'
library(tidyverse)

data = read_csv('humanos.csv')
View(data)

# ggplot funciona de manera secuencial igual que las funciones del paquete dplyr
# al usar 'pipeline', solo que en vez de usar '%>%' se usa el signo '+'.

# La estructura del paquete ggplot nos permite generar gr�ficos de la misma forma
# que un animador genera sus animaciones: por capas. Y al igual que un animador,
# vamos desde lo m�s "grueso" a lo m�s "fino".

# Siempre que empecemos con un gr�fico, debemos inicializar un objeto ggplot().
# Este es un gr�fico vac�o y en �l debemos indicar la base de datos que usaremos.
p = ggplot(data=data); p

# En la ventana de 'Plots' vemos un gr�fico vac�o. Sobre este iremos agregando 
# capas. El tipo de gr�fico se define con las funciones 'geom':
# geom_point, geom_boxplot, geom_bar, geom_errorbar, geom_histogram, etc...
# Ahora trataremos de replicar los gr�ficos de la clase pasada.

# Gr�fico de barras para Nacionalidad. Para precisar que ejes debe tener la figura
# debemos generar un objeto 'aes()' (de aesthetics). En este caso el gr�fico
# solo tiene una variable (x). La otra variable es la frecuencia de la primera.
p + geom_bar(mapping=aes(x=Sexo))

# El gr�fico no parece muy distinto al que generamos la clase pasada,
# a pesar de haber usado m�s c�digo. La gracia de ggplot es que podemos 
# personalizarlo facilmente.
p + geom_bar(mapping=aes(x=Sexo))+ 
  labs(y='Frecuencia')+
  scale_x_discrete(limits=c('Mujer','Hombre','Otro'))

# Podemos agregar colores usando su c�digo nominal o hexadecimal. Podemos cambiar
# el contorno de las figuras con 'col' y su relleno con 'fill'
p + geom_bar(mapping=aes(x=Sexo), fill='grey50', col='black') + 
  labs(y='Frecuencia')+
  scale_x_discrete(limits=c('Mujer','Hombre','Otro'))

p + geom_bar(mapping=aes(x=Sexo), fill='#123456', col='#ff0000') + 
  labs(y='Frecuencia')+
  scale_x_discrete(limits=c('Mujer','Hombre','Otro'))

# Minitarea
# Busca el codigo nominal y HEX de 3 colores. Construye un gr�fico y colorea cada
# barra de un color distinto. 
# Recuerda que varias funciones en R trabajan con vectores.

# Histograma para edad
p + geom_histogram(aes(x=Edad))

# Podemos precisar el grosor de cada barra y sus colores
p + geom_histogram(aes(x=Edad), col='black', binwidth=5) +
  labs(y='Frecuencia')

# Tambi�n separar por alguna otra variable.
p + geom_histogram(aes(x=Edad, fill=Sexo), col='black', binwidth=5) +
  labs(y='Frecuencia')

# Minitarea:
# Representa la variable Color.ojos con el color de las barras. 
# Cambia el nombre del factor a 'Color de ojos' y ponle un t�tulo a la figura.

# Gr�fico de cajas para la Edad por Sexo
p + geom_boxplot(aes(x=Sexo, y=Edad))

# Minitarea:
# Genera un gr�fico similar pero utiliza Estatura para el eje y.
# Revisa la CheatSheet de ggplot2 y busca alg�n otro gr�fico similar a boxplot.

# Grafico de dispersi�n
p + geom_point(aes(x=Estatura, y=Masa))

# Minitarea:
# Personaliza tu gr�fico seg�n lo que hemos visto hasta el momento
# Ten en mente que los puntos no tienen relleno.
# (Busca los argumentos que tiene la funci�n geom_point)

# ggplot tiene "temas" predefinidos. Una buena opci�n es 'theme_classic()'.
p + geom_point(aes(x=Estatura, y=Masa)) + theme_classic()
p + geom_point(aes(x=Estatura, y=Masa)) + theme_light()
p + geom_point(aes(x=Estatura, y=Masa)) + theme_minimal()

# Un tipo de gr�fico menos com�n, pero super �til en algunas circunstancias, es
# cambiar los puntos por palabras.
p + geom_label(aes(x=Estatura, y=Masa, label=Nombre))


# Hacer gr�ficos de barra con barras de error requiere un poco m�s de trabajo.
# Graficaremos la Estatura por Sexo.

# Primero, debemos calcular los valores que queremos representar con las barras 
# de error. En este caso calcularemos el error est�ndar del promedio de cada grupo,
# por lo tanto, tenemos que calcular el valor del error est�ndar y los promedios.
# Recordatorio: Error.estandar = sqrt(var/n)
resumen = data %>% group_by(Sexo) %>% summarise(error.estandar=sqrt(var(Estatura)/n()),
                                                promedio=mean(Estatura)); resumen

# Segundo, hacemos el gr�fico de barras. Esta vez lo haremos un poco distinto.
# Debido a haremos "dos gr�ficos en uno", precisaremos 'x' e 'y' en aes() de ggplot().
p = ggplot(data=resumen, aes(x=Sexo, y=promedio))
p + geom_col() +
# Tercero, agregar las barras de error. Estas se encuentran en otra base de datos,
# por lo que tendremos que precisar nuevamente que datos usaremos. 
# El argumento de 'mapping' es un poco distinto tambi�n, debemos precisar el 
# valor m�nimo y m�ximo de la barra de error.
  geom_errorbar(aes(ymin=promedio-error.estandar, 
                    ymax=promedio+error.estandar),
                width=0.1)


# PROTIP: Un c�digo ordenado no s�lo se ve bien, tambi�n ayuda a saber 
# la extensi�n de sus partes. Usa Enter dentro de los par�ntesis para
# mantener el c�digo alineado.


# Gr�fico de lineas (serie de tiempo)
data = data.frame('level'=as.vector(LakeHuron), 'year'= 1875:1972)
p = ggplot(data, aes(x=year, y=level))
p + geom_line()

# Por �ltimo, puedes guardar un gr�fico de varias formas. 
# Aqu� van 3:
# 1. Export
# 2. Bot�n derecho
# 3. ggsave()

ggsave('Mi primer gr�fico.png', plot=last_plot())

primer_grafico = p + geom_col() + 
  geom_errorbar(aes(ymin=promedio-error.estandar,
                    ymax=promedio+error.estandar),
                width=0.1)
ggsave('Mi primer gr�fico.png', plot=primer_grafico)













