# 'ggplot2' es un paquete para graficar y está dentro del paquete 'tidyverse'
library(tidyverse)

data = read_csv('humanos.csv')
View(data)

# ggplot funciona de manera secuencial igual que las funciones del paquete dplyr
# al usar 'pipeline', solo que en vez de usar '%>%' se usa el signo '+'.

# La estructura del paquete ggplot nos permite generar gráficos de la misma forma
# que un animador genera sus animaciones: por capas. Y al igual que un animador,
# vamos desde lo más "grueso" a lo más "fino".

# Siempre que empecemos con un gráfico, debemos inicializar un objeto ggplot().
# Este es un gráfico vacío y en él debemos indicar la base de datos que usaremos.
p = ggplot(data=data); p

# En la ventana de 'Plots' vemos un gráfico vacío. Sobre este iremos agregando 
# capas. El tipo de gráfico se define con las funciones 'geom':
# geom_point, geom_boxplot, geom_bar, geom_errorbar, geom_histogram, etc...
# Ahora trataremos de replicar los gráficos de la clase pasada.

# Gráfico de barras para Nacionalidad. Para precisar que ejes debe tener la figura
# debemos generar un objeto 'aes()' (de aesthetics). En este caso el gráfico
# solo tiene una variable (x). La otra variable es la frecuencia de la primera.
p + geom_bar(mapping=aes(x=Sexo))

# El gráfico no parece muy distinto al que generamos la clase pasada,
# a pesar de haber usado más código. La gracia de ggplot es que podemos 
# personalizarlo facilmente.
p + geom_bar(mapping=aes(x=Sexo))+ 
  labs(y='Frecuencia')+
  scale_x_discrete(limits=c('Mujer','Hombre','Otro'))

# Podemos agregar colores usando su código nominal o hexadecimal. Podemos cambiar
# el contorno de las figuras con 'col' y su relleno con 'fill'
p + geom_bar(mapping=aes(x=Sexo), fill='grey50', col='black') + 
  labs(y='Frecuencia')+
  scale_x_discrete(limits=c('Mujer','Hombre','Otro'))

p + geom_bar(mapping=aes(x=Sexo), fill='#123456', col='#ff0000') + 
  labs(y='Frecuencia')+
  scale_x_discrete(limits=c('Mujer','Hombre','Otro'))

# Minitarea
# Busca el codigo nominal y HEX de 3 colores. Construye un gráfico y colorea cada
# barra de un color distinto. 
# Recuerda que varias funciones en R trabajan con vectores.

# Histograma para edad
p + geom_histogram(aes(x=Edad))

# Podemos precisar el grosor de cada barra y sus colores
p + geom_histogram(aes(x=Edad), col='black', binwidth=5) +
  labs(y='Frecuencia')

# También separar por alguna otra variable.
p + geom_histogram(aes(x=Edad, fill=Sexo), col='black', binwidth=5) +
  labs(y='Frecuencia')

# Minitarea:
# Representa la variable Color.ojos con el color de las barras. 
# Cambia el nombre del factor a 'Color de ojos' y ponle un título a la figura.

# Gráfico de cajas para la Edad por Sexo
p + geom_boxplot(aes(x=Sexo, y=Edad))

# Minitarea:
# Genera un gráfico similar pero utiliza Estatura para el eje y.
# Revisa la CheatSheet de ggplot2 y busca algún otro gráfico similar a boxplot.

# Grafico de dispersión
p + geom_point(aes(x=Estatura, y=Masa))

# Minitarea:
# Personaliza tu gráfico según lo que hemos visto hasta el momento
# Ten en mente que los puntos no tienen relleno.
# (Busca los argumentos que tiene la función geom_point)

# ggplot tiene "temas" predefinidos. Una buena opción es 'theme_classic()'.
p + geom_point(aes(x=Estatura, y=Masa)) + theme_classic()
p + geom_point(aes(x=Estatura, y=Masa)) + theme_light()
p + geom_point(aes(x=Estatura, y=Masa)) + theme_minimal()

# Un tipo de gráfico menos común, pero super útil en algunas circunstancias, es
# cambiar los puntos por palabras.
p + geom_label(aes(x=Estatura, y=Masa, label=Nombre))


# Hacer gráficos de barra con barras de error requiere un poco más de trabajo.
# Graficaremos la Estatura por Sexo.

# Primero, debemos calcular los valores que queremos representar con las barras 
# de error. En este caso calcularemos el error estándar del promedio de cada grupo,
# por lo tanto, tenemos que calcular el valor del error estándar y los promedios.
# Recordatorio: Error.estandar = sqrt(var/n)
resumen = data %>% group_by(Sexo) %>% summarise(error.estandar=sqrt(var(Estatura)/n()),
                                                promedio=mean(Estatura)); resumen

# Segundo, hacemos el gráfico de barras. Esta vez lo haremos un poco distinto.
# Debido a haremos "dos gráficos en uno", precisaremos 'x' e 'y' en aes() de ggplot().
p = ggplot(data=resumen, aes(x=Sexo, y=promedio))
p + geom_col() +
# Tercero, agregar las barras de error. Estas se encuentran en otra base de datos,
# por lo que tendremos que precisar nuevamente que datos usaremos. 
# El argumento de 'mapping' es un poco distinto también, debemos precisar el 
# valor mínimo y máximo de la barra de error.
  geom_errorbar(aes(ymin=promedio-error.estandar, 
                    ymax=promedio+error.estandar),
                width=0.1)


# PROTIP: Un código ordenado no sólo se ve bien, también ayuda a saber 
# la extensión de sus partes. Usa Enter dentro de los paréntesis para
# mantener el código alineado.


# Gráfico de lineas (serie de tiempo)
data = data.frame('level'=as.vector(LakeHuron), 'year'= 1875:1972)
p = ggplot(data, aes(x=year, y=level))
p + geom_line()

# Por último, puedes guardar un gráfico de varias formas. 
# Aquí van 3:
# 1. Export
# 2. Botón derecho
# 3. ggsave()

ggsave('Mi primer gráfico.png', plot=last_plot())

primer_grafico = p + geom_col() + 
  geom_errorbar(aes(ymin=promedio-error.estandar,
                    ymax=promedio+error.estandar),
                width=0.1)
ggsave('Mi primer gráfico.png', plot=primer_grafico)













